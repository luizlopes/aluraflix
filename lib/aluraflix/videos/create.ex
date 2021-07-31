defmodule Aluraflix.Videos.Create do
  alias Aluraflix.{Repo, Video}

  def call(params) do
    params
    |> Video.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, video} = result), do: {:ok, Repo.preload(video, [:categories])}
  defp handle_insert({:error, channgeset}), do: {:error, channgeset}
end
