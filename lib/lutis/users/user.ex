defmodule Lutis.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
  end

  @doc false
  def username_changeset(user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required(:username)
    |> validate_length(:username, min: 3)
    |> unique_constraint(:username)
  end

end
