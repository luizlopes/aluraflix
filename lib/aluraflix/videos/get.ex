defmodule Aluraflix.Videos.Get do
  alias Aluraflix.{Repo, Video}

  def call(%{"id" => id}) do
    case Repo.get(Video, id) do
      nil -> {:error, :not_found}
      video -> {:ok, video}
    end
  end
end
