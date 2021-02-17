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

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
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

  def validate_author(%Post{} = post, conn) do
    cond do
      post.author == conn.assigns.user_id -> :ok
      true -> %{errors: %{user: ["unauthorized"]}}
    end
  end
end
