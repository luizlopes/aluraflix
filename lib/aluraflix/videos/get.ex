defmodule Aluraflix.Videos.Get do
  alias Aluraflix.{Repo, Video}

  def call(%{"id" => id}) do
    case Repo.get(Video, id) do
      nil -> {:error, :not_found}
      video -> {:ok, load_categories(video)}
    end
  end

  defp load_categories(video) do
    video |> Repo.preload([:categories])
  end
end
