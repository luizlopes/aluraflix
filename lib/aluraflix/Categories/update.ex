defmodule Aluraflix.Categories.Update do
  alias Aluraflix.{Category, Repo}

  def call(category, params) do
    category
    |> Category.changeset(params)
    |> Repo.update(stale_error_field: :my_errors)
    |> handle_update
  end

  defp handle_update({:ok, _} = result), do: result
  defp handle_update({:error, channgeset}), do: {:error, channgeset}
end
