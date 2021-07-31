defmodule Aluraflix.VideoCategory do
  use Ecto.Schema
  import Ecto.Changeset

  alias Aluraflix.{Video, Category}

  @required_params [:video_id, :category_id]

  schema "videos_categories" do
    belongs_to :video, Video
    belongs_to :category, Category

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
