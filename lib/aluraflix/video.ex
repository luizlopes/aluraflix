defmodule Aluraflix.Video do
  use Ecto.Schema
  import Ecto.Changeset

  @required_params [:title, :description, :url]

  schema "videos" do
    field :title, :string
    field :description, :string
    field :url, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:title, min: 3, max: 50)
  end
end
