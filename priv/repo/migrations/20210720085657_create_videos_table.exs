defmodule Aluraflix.Repo.Migrations.CreateVideosTable do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :title, :string
      add :description, :string
      add :url, :string

      timestamps()
    end
  end
end
