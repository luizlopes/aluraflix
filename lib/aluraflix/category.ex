defmodule Aluraflix.Category do
  use Ecto.Schema
  import Ecto.Changeset

  alias Aluraflix.{Video, VideoCategory}

  @required_params [:title, :color]

  schema "categories" do
    field :title, :string
    field :color, :string
    many_to_many :videos, Video, join_through: VideoCategory

    timestamps()
  end

  def changeset(params) do
    changeset(%__MODULE__{}, params)
  end

  def changeset(%__MODULE__{} = category, params) do
    category
    |> cast_and_validate(params)
  end

  defp cast_and_validate(category, params) do
    category
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:title, min: 3, max: 50)
    |> validate_length(:color, min: 3, max: 50)
  end
end
