defmodule Aluraflix.Repo.Migrations.CreateCategoriesTable do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :title, :string
      add :color, :string

      timestamps()
    end
  end
end
