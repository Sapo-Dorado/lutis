defmodule Lutis.Posting do

  import Ecto.Query, warn: false
  alias Lutis.Repo

  alias Lutis.Posting.Post

  def list_posts do
    Repo.all(Post)
  end

  def get_post!(id) do
    Repo.get!(Post, id)
  end

  def create_post(user_id, attrs \\ %{}) do
    %Post{}
    |> Post.changeset(Map.put(attrs, "author", user_id))
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  def validate_author(conn, %Post{} = post) do
    cond do
      post.author == conn.assigns.user_id -> :ok
      true -> {:error, :unauthorized}
    end
  end
end
