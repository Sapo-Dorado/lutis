defmodule Lutis.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :username, :string
      add :oauth_token, :string

      timestamps()
    end

    create unique_index(:users, [:username])

  end
end
