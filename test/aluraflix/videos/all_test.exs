defmodule Aluraflix.Videos.GetTest do
  use Aluraflix.DataCase, async: true

  alias Aluraflix.{Video, Category}
  alias Aluraflix.Videos.All
  alias Aluraflix.Videos.Create, as: CreateVideo
  alias Aluraflix.Categories.Create, as: CreateCategory

  describe "call/1" do
    test "when params are empty, then return all videos" do
      data_setup()

      params = %{}

      result = All.call(params)

      assert [
               %Video{
                 title: "video #01",
                 description: "video 1...",
                 categories: [
                   %Category{
                     title: "category #01",
                     color: "blank"
                   },
                   %Category{
                     title: "category #02",
                     color: "black"
                   }
                 ]
               },
               %Video{
                 title: "video #02",
                 description: "video 2...",
                 categories: [
                   %Category{
                     title: "category #02",
                     color: "black"
                   }
                 ]
               }
             ] = result
    end

    test "when params has a valid category id, then return videos for that category" do
      %{category_01: category_01} = data_setup()

      params = %{"category_id" => category_01}

      result = All.call(params)

      assert length(result) == 2
    end

    test "when params has an invalid category id, then return error" do
      data_setup()

      params = %{"categories_id" => 10909}

      result = All.call(params)

      assert result == []
    end

    defp data_setup() do
      create_video_params_01 = %{
        title: "video #01",
        description: "video 1...",
        url: "http://yt/video/1"
      }

      create_video_params_02 = %{
        title: "video #02",
        description: "video 2...",
        url: "http://yt/video/2"
      }

      {:ok, %Video{id: video_01_id}} = CreateVideo.call(create_video_params_01)
      {:ok, %Video{id: video_02_id}} = CreateVideo.call(create_video_params_02)

      create_category_params_01 = %{title: "category #01", color: "blank"}
      create_category_params_02 = %{title: "category #02", color: "black"}

      {:ok, %Category{id: category_01_id}} = CreateCategory.call(create_category_params_01)
      {:ok, %Category{id: category_02_id}} = CreateCategory.call(create_category_params_02)

      video_category_params_01 = %{video_id: video_01_id, category_id: category_01_id}
      video_category_params_02 = %{video_id: video_01_id, category_id: category_02_id}
      video_category_params_03 = %{video_id: video_02_id, category_id: category_02_id}

      video_category_params_01 |> Aluraflix.VideoCategory.changeset() |> Aluraflix.Repo.insert()
      video_category_params_02 |> Aluraflix.VideoCategory.changeset() |> Aluraflix.Repo.insert()
      video_category_params_03 |> Aluraflix.VideoCategory.changeset() |> Aluraflix.Repo.insert()

      %{category_01: category_01_id, category_02: category_02_id}
    end
  end
end
