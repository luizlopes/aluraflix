defmodule Aluraflix.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:name, :email, :password]
  @derive {Jason.Encoder, only: [:name, :email]}

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:name, min: 3, max: 50)
    |> validate_length(:email, min: 3, max: 50)
    |> validate_length(:password, min: 3, max: 50)
  end
end
