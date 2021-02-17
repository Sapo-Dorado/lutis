defmodule Lutis.Users do
  import Ecto.Query, warn: false
  alias Lutis.Repo

  alias Lutis.Users.User

  def get_user(email) do
    User
    |> Repo.get_by(email: email)
  end
  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def add_username(email, username) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, %{"user" => ["does not exist"]}}
      user ->
        user
        |> User.username_changeset(%{username: username})
        |> Repo.update()
    end
  end
end
