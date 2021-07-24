defmodule Aluraflix.Videos.Update do
  alias Aluraflix.{Video, Repo}

  def call(video, params) do
    video
    |> Video.changeset(params)
    |> Repo.update([stale_error_field: :my_errors])
    |> handle_update
  end

  defp handle_update({:ok, _} = result), do: result
  defp handle_update({:error, channgeset}), do: {:error, channgeset}
end
