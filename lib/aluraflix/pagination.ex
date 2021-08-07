defmodule Aluraflix.Pagination do
  import Ecto.Query

  alias Aluraflix.Repo

  def paginate(queryable, opts \\ []) do
    page = opts[:page] || 1
    per_page = opts[:per_page] || 5
    preload = opts[:preload] || []

    paginate(queryable, page, per_page, preload)
  end

  defp paginate(queryable, page, per_page, preload) when is_binary(page),
    do: paginate(queryable, String.to_integer(page), per_page, preload)

  defp paginate(queryable, page, per_page, preload) when is_binary(per_page),
    do: paginate(queryable, page, String.to_integer(per_page), preload)

  defp paginate(queryable, page, per_page, preload) do
    result = execute_query(queryable, page, per_page, preload)
    total_count = total_count(queryable)

    %{
      "pagination" => %{
        "page" => page,
        "per_page" => per_page,
        "page_count" => page_count(total_count, per_page),
        "total_count" => total_count
      },
      "result" => result
    }
  end

  defp execute_query(queryable, page, per_page, preload) do
    limit = per_page
    offset = (page - 1) * per_page

    queryable
    |> limit(^limit)
    |> offset(^offset)
    |> Repo.all()
    |> Repo.preload(preload)
  end

  defp total_count(queryable) do
    Repo.one(from(t in subquery(queryable), select: count("1")))
  end

  defp page_count(total_count, per_page) do
    case {total_count, rem(total_count, per_page), div(total_count, per_page)} do
      {0, _, _} -> 0
      {_, 0, div} -> div
      {_, _, div} -> div + 1
    end
  end
end
