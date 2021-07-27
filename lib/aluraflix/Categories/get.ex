defmodule Aluraflix.Categories.Get do
  alias Aluraflix.{Repo, Category}

  def call(%{"id" => id}) do
    case Repo.get(Category, id) do
      nil -> {:error, :not_found}
      category -> {:ok, category}
    end
  end
end
