defmodule Aluraflix.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true, default: {:fragment, "uuid_generate_v1()"}
      add :name, :string, null: false
      add :email, :string, null: false
      add :password, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
