defmodule Aluraflix.Videos.GetTest do
  use Aluraflix.DataCase, async: true

  alias Aluraflix.Video
  alias Aluraflix.Videos.Get

  describe "call/1" do
    test "when id doesn't exist, then return error with not_found status" do
      id = 345
      result = Get.call(%{"id" => id})

      assert {:error, :not_found} = result
    end

    test "when id exists, then return ok with video record" do
      params = %{title: "video #01", description: "video 1...", url: "http://yt/video/1"}

      {:ok, %Video{id: id}} =
        params
        |> Video.changeset()
        |> Repo.insert()

      result = Get.call(%{"id" => id})

      assert {:ok,
              %Video{
                id: ^id,
                title: "video #01",
                description: "video 1...",
                url: "http://yt/video/1",
                categories: []
              }} = result
    end
  end
end
