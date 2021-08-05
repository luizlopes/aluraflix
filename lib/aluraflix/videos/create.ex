defmodule Aluraflix.Videos.Create do
  import Ecto.Query

  alias Aluraflix.{Repo, Video, Category, VideoCategory}

  def call(params) do
    params
    |> insert_video()
    |> insert_video_categories(params)
  end

  defp insert_video(params) do
    params
    |> Video.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Video{}} = result), do: result
  defp handle_insert({:error, channgeset}), do: {:error, channgeset}

  defp insert_video_categories(inserted_video, params) do
    with {:ok, %Video{id: video_id} = video} <- inserted_video do
      params
      |> prepare_video_category_params(video_id)
      |> Enum.each(&insert_video_category(&1))

      {:ok, Repo.preload(video, [:categories])}
    end
  end

  defp prepare_video_category_params(
         %{"categories" => categories},
         video_id
       )
       when is_list(categories) do
    categories
    |> Enum.map(fn category -> %{video_id: video_id, category_id: category["id"]} end)
  end

  defp prepare_video_category_params(_params, video_id) do
    [%{video_id: video_id, category_id: default_category_id}]
  end

  defp default_category_id do
    Category |> limit(1) |> Repo.one() |> Map.get(:id)
  end

  defp insert_video_category(params) do
    params
    |> VideoCategory.changeset()
    |> Repo.insert()
  end
end
