defmodule Aluraflix.Videos.UpdateTest do
  use Aluraflix.DataCase, async: true

  alias Aluraflix.Video
  alias Aluraflix.Videos.{Create, Update}

  describe "update/2" do
    test "Given an video, when all params are valid, then update a video record" do
      create_params = %{title: "video #01", description: "video 1...", url: "http://yt/video/1"}

      {:ok, %Video{id: id} = video} = Create.call(create_params)

      update_params = %{title: "Updated Video", description: "This video record was updated", url: "http://updating.co"}

      result = Update.call(video, update_params)

      assert {:ok,
              %Video{
                id: ^id,
                title: "Updated Video",
                description: "This video record was updated",
                url: "http://updating.co"
              }} = result
    end

    test "Given an video, when there are invalid params, then return a error message" do
      create_params = %{title: "video #01", description: "video 1...", url: "http://yt/video/1"}

      {:ok, video} = Create.call(create_params)

      update_params = %{title: ".", description: ".", url: "yt/video/1"}

      {:error, result} = Update.call(video, update_params)

      assert %{
                description: ["should be at least 3 character(s)"],
                title: ["should be at least 3 character(s)"]
              } = errors_on(result)
    end
  end
end
