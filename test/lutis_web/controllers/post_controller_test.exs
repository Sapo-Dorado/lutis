defmodule LutisWeb.PostControllerTest do
  use LutisWeb.ConnCase

  import Mock

  alias Lutis.Users
  alias Lutis.Posting
  alias Lutis.Posting.Post

  @valid_email "valid@email.com"
  @valid_token "token"
  @other_valid_token "token2"

  @create_attrs %{
    "contents" => "some contents",
    "title" => "some title",
  }
  @update_attrs %{
    "contents" =>"some updated contents",
    "title" => "some updated title",
  }
  @invalid_attrs %{author: nil, contents: nil, title: nil}

  @user_attrs %{email: @valid_email, username: "some username"}
  @other_user_attrs %{email: "other@email.com", username: "other username"}

  setup_with_mocks([
    {Ueberauth.Strategy.Google.OAuth, [], [get: fn(token, _url) ->
      case token do
        "token" ->
          {:ok, %OAuth2.Response{body: %{"email" => @valid_email}}}
        "token2" ->
          {:ok, %OAuth2.Response{body: %{"email" => @other_user_attrs.email}}}
        _ -> :error
      end
    end]}
  ]) do
    :ok
  end

  def fixture(:user) do
    {:ok, user} = Users.create_user(@user_attrs)
    user
  end

  def fixture(:other_user) do
    {:ok, user} = Users.create_user(@other_user_attrs)
    user
  end

  def fixture(:post) do
    user = fixture(:user)
    {:ok, post} = Posting.create_post(user.id, @create_attrs)
    post
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create post" do
    test "renders post when data is valid", %{conn: conn} do
      fixture(:user)
      conn = post(conn, Routes.post_path(conn, :create), post: @create_attrs, email: @valid_email, token: @valid_token)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.post_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "contents" => "some contents",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid or user is unauthorized", %{conn: conn} do
      fixture(:user)
      conn = post(conn, Routes.post_path(conn, :create), post: @invalid_attrs, email: @valid_email, token: @valid_token)
      assert json_response(conn, 422)["errors"] != %{}

      conn = post(conn, Routes.post_path(conn, :create), post: @create_attrs)
      assert json_response(conn, 401)["errors"] != %{}
    end
  end

  describe "update post" do
    setup [:create_post]

    test "renders post when data is valid", %{conn: conn, post: %Post{id: id, author: author} = post} do
      conn = put(conn, Routes.post_path(conn, :update, post), post: @update_attrs, email: @valid_email, token: @valid_token)
      assert %{"id" => ^id, "author" => ^author} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.post_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "author" => ^author,
               "contents" => "some updated contents",
               "title" => "some updated title",
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      fixture(:other_user)

      conn = put(conn, Routes.post_path(conn, :update, post), post: @invalid_attrs, email: @valid_email, token: @valid_token)
      assert json_response(conn, 422)["errors"] != %{}

      conn = put(conn, Routes.post_path(conn, :update, post), post: @create_attrs)
      assert json_response(conn, 401)["errors"] != %{}

      conn = put(conn, Routes.post_path(conn, :update, post), post: @create_attrs, email: @other_user_attrs.email, token: @other_valid_token)
      assert json_response(conn, 401)["errors"] != %{}
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, Routes.post_path(conn, :delete, post), email: @valid_email, token: @valid_token)
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.post_path(conn, :show, post))
      end
    end

    test "renders errors and doesn't delete when user is unauthorized", %{conn: conn, post: %Post{id: id, author: author, contents: contents} = post} do
      fixture(:other_user)
      conn = delete(conn, Routes.post_path(conn, :delete, post), email: @other_user_attrs.email, token: @other_valid_token)
      assert json_response(conn, 401)["errors"] != %{}

      conn = get(conn, Routes.post_path(conn, :show, post))
      assert %{ "id" => ^id, "author" => ^author, "contents" => ^contents} = json_response(conn, 200)["data"]
    end
  end

  defp create_post(_) do
    post = fixture(:post)
    %{post: post}
  end
end
