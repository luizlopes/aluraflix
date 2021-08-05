defmodule Aluraflix.Videos.CreateTest, async: true do
  use Aluraflix.DataCase

  alias Aluraflix.{Video, Category}
  alias Aluraflix.Videos.Create

  describe "create/1" do
    test "when all params are valid, then create a video record" do
      {:ok, %Category{id: category_id}} =
        Aluraflix.Categories.Create.call(%{"title" => "Free", "color" => "Green"})

      params = %{
        "title" => "video #01",
        "description" => "video 1...",
        "url" => "http://yt/video/1",
        "categories" => [%{"id" => category_id}]
      }

      result = Create.call(params)

      assert {:ok,
              %Video{
                id: _id,
                title: "video #01",
                description: "video 1...",
                url: "http://yt/video/1",
                categories: [
                  %Category{
                    id: ^category_id,
                    title: "Free",
                    color: "Green"
                  }
                ]
              }} = result
    end

    test "when there are invalid params, then return a error message" do
      params = %{title: ".", description: ".", url: "yt/video/1"}

      {:error, result} = Create.call(params)

      assert %{
               description: ["should be at least 3 character(s)"],
               title: ["should be at least 3 character(s)"]
             } = errors_on(result)
    end

    test "when params is empty, then return a error message" do
      params = %{}

      {:error, result} = Create.call(params)

      assert %{
               description: ["can't be blank"],
               title: ["can't be blank"],
               url: ["can't be blank"]
             } = errors_on(result)
    end
  end
end
