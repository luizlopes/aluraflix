defmodule Aluraflix.Videos.AllTest do
  use Aluraflix.DataCase, async: true
  import Aluraflix.Factory

  alias Aluraflix.{Video, Category}
  alias Aluraflix.Videos.All

  setup do
    category_01 = insert!(:category, %{title: "category #01", color: "blank"})
    category_02 = insert!(:category, %{title: "category #02", color: "black"})

    video_01 = insert!(:video)
    video_02 = insert!(:video, %{title: "video #02"})

    insert!(:video_category, %{video_id: video_01.id, category_id: category_01.id})
    insert!(:video_category, %{video_id: video_01.id, category_id: category_02.id})
    insert!(:video_category, %{video_id: video_02.id, category_id: category_02.id})

    {:ok, %{category_01: category_01.id, category_02: category_02.id}}
  end

  describe "call/1" do
    test "when params are empty, then return all videos" do
      params = %{}

      result = All.call(params)

      assert [
               %Video{
                 title: "video #01",
                 description: _,
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
                 description: _,
                 categories: [
                   %Category{
                     title: "category #02",
                     color: "black"
                   }
                 ]
               }
             ] = result
    end

    test "when params has a search query with exactly title, then return matched videos" do
      params = %{"search" => "video #02"}

      result = All.call(params)

      assert [
               %Video{
                 title: "video #02",
                 description: _,
                 categories: [
                   %Category{
                     title: "category #02",
                     color: "black"
                   }
                 ]
               }
             ] = result
    end

    test "when params has a search query with title, then return matched videos" do
      params = %{"search" => "video"}

      result = All.call(params)

      assert [
               %Video{
                 title: "video #01",
                 description: _
               },
               %Video{
                 title: "video #02",
                 description: _,
                 categories: [
                   %Category{
                     title: "category #02",
                     color: "black"
                   }
                 ]
               }
             ] = result
    end

    test "when params has a valid category id, then return videos for that category", %{
      category_01: category_01
    } do
      params = %{"category_id" => category_01}

      result = All.call(params)

      assert length(result) == 2
    end

    test "when params has an invalid category id, then return error" do
      params = %{"categories_id" => 10909}

      result = All.call(params)

      assert result == []
    end
  end
end
