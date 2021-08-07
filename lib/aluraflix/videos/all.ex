defmodule Aluraflix.Videos.All do
  import Ecto.Query

  alias Aluraflix.{Video, Pagination}

  def call(params) do
    opts = [
      page: Map.get(params, "page"),
      per_page: Map.get(params, "per_page"),
      preload: [:categories]
    ]

    get_query(params) |> paginate(opts)
  end

  defp get_query(%{"search" => searched_string}) when is_binary(searched_string),
    do: by_title(searched_string)

  defp get_query(%{"categories_id" => category_id}) when is_binary(category_id),
    do: by_category(category_id)

  defp get_query(_), do: Video

  defp by_category(category_id) do
    from v in Video,
      join: c in assoc(v, :categories),
      where: c.id == ^category_id
  end

  defp by_title(searched_string) do
    like = "#{searched_string}%"

    from v in Video,
      where: ilike(v.title, ^like)
  end

  defp paginate(query, opts) do
    query |> Pagination.paginate(opts)
  end
end
