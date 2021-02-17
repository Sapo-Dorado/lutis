defmodule Lutis.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :author, :integer
      add :title, :string
      add :contents, :text
      add :upvotes, :integer, default: 0
      add :views, :integer, default: 0

      timestamps()
    end

  end
end
