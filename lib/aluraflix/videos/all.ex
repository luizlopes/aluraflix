defmodule Aluraflix.Videos.All do
  import Ecto.Query

  alias Aluraflix.{Repo, Video}

  def call(params) do
    do_call(params)
  end

  defp do_call(%{"categories_id" => category_id}), do: by_category(category_id)
  defp do_call(%{"search" => searched_string}), do: by_title(searched_string)
  defp do_call(%{}), do: Repo.all(Video) |> Repo.preload([:categories])

  defp by_category(category_id) do
    query =
      from v in Video,
        join: c in assoc(v, :categories),
        where: c.id == ^category_id

    Repo.all(query) |> Repo.preload([:categories])
  end

  defp by_title(searched_string) do
    like = "#{searched_string}%"

    query =
      from v in Video,
        where: ilike(v.title, ^like)

    Repo.all(query) |> Repo.preload([:categories])
  end
end
