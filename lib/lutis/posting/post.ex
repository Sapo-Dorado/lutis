defmodule Lutis.Posting.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :author, :integer
    field :contents, :string
    field :title, :string
    field :upvotes, :integer
    field :views, :integer

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:author, :title, :contents])
    |> validate_required([:author, :title, :contents])
  end
end
