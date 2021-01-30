defmodule LutisWeb.AuthControllerTest do
  use LutisWeb.ConnCase

  import Plug.Conn.Query
  import String

  alias Lutis.Users

  @example_email "test@example.com"
  @example_token "example token"
  @user_attrs %{email: @example_email, oauth_token: @example_token}
  @ueberauth_auth %{
    credentials: %{token: @example_token},
    info: %{email: @example_email},
    provider: :google
  }


  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@user_attrs)
      |> Users.create_user()

    user
  end

  test "call to /auth/google redirects to google auth", %{conn: conn} do
    conn = get(conn, "/auth/google")
    assert contains?(redirected_to(conn, 302), "accounts.google.com")
  end
  test "callback without proper authentication redirects to home", %{conn: conn} do
    conn = get(conn, "/auth/google/callback")
    assert redirected_to(conn, 302) == "/"
  end

  test "callback with proper authentication redirects to home with user params if user does not exist", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth_auth)
      |> get("/auth/google/callback")
    params = decode(replace_leading(redirected_to(conn, 302), "/?", ""))
    assert params["email"] == @example_email
    assert params["token"] == @example_token
  end

  test "callback with proper authentication redirects to home with user params if user exists", %{conn: conn} do
    user_fixture()
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth_auth)
      |> get("/auth/google/callback")
    params = decode(replace_leading(redirected_to(conn, 302), "/?", ""))
    assert params["email"] == @example_email
    assert params["token"] == @example_token
  end

end
