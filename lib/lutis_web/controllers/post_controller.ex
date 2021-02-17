defmodule LutisWeb.PostController do
  use LutisWeb, :controller

  alias Lutis.Posting
  alias Lutis.Posting.Post

  action_fallback LutisWeb.FallbackController

  def index(conn, _params) do
    posts = Posting.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Posting.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Posting.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posting.get_post!(id)

    with :ok <- Posting.validate_author(conn, post),
        {:ok, %Post{} = post} <- Posting.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posting.get_post!(id)

    with :ok <- Posting.validate_author(conn, post),
        {:ok, %Post{}} <- Posting.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
