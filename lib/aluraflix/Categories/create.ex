defmodule Aluraflix.Categories.Create do
  alias Aluraflix.{Repo, Category}

  def call(params) do
    params
    |> Category.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, _} = result), do: result
  defp handle_insert({:error, channgeset}), do: {:error, channgeset}
end
