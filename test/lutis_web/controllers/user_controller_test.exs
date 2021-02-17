defmodule LutisWeb.UserControllerTest do
  use LutisWeb.ConnCase
  import Mock

  alias Lutis.Users

  @valid_token "token"
  @user_attrs %{email: "example@email.com", username: "Test Username"}

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@user_attrs)
      |> Users.create_user()
    user
  end

  setup_with_mocks([
    {Ueberauth.Strategy.Google.OAuth, [], [get: fn(token, _url) ->
      case token do
        "token" ->
          {:ok, %OAuth2.Response{body: %{"email" => @user_attrs.email}}}
        _ -> :error
      end
    end]}
  ]) do
    :ok
  end

  test "POST /api/username returns error with invalid authentication", %{conn: conn} do
    conn = post(conn, "/api/username")
    assert json_response(conn, 200)["errors"] != %{}
  end

  test "POST /api/username returns error with invalid username", %{conn: conn} do
    user_fixture()
    conn = post(conn, "/api/username", token: @valid_token, email: @user_attrs.email, username: "")
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "POST /api/username returns error when user doesn't exist", %{conn: conn} do
    conn = post(conn, "/api/username", token: @valid_token, email: @user_attrs.email, username: @user_attrs.username)
    assert json_response(conn, 500)["errors"] != %{}
  end

  test "POST /api/username updates username with valid inputs", %{conn: conn} do
    user_fixture()
    conn = post(conn, "/api/username", token: @valid_token, email: @user_attrs.email, username: @user_attrs.username)
    assert json_response(conn, 200)["data"]["username"] == @user_attrs.username
  end

end
