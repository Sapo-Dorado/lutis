defmodule Lutis.Users do
  import Ecto.Query, warn: false
  alias Lutis.Repo

  alias Lutis.Users.User

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_token(user, token) do
    user
    |> User.changeset(%{oauth_token: token})
    |> Repo.update()
  end
end
