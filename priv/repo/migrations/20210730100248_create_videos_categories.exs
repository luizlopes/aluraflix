defmodule Aluraflix.Repo.Migrations.CreateVideosCategories do
  use Ecto.Migration

  def change do
    create table(:videos_categories) do
      add :category_id, references(:categories, type: :integer, on_delete: :nothing)
      add :video_id, references(:videos, type: :integer, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:videos_categories, [:video_id, :category_id])
  end
end
