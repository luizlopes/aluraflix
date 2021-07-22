defmodule Aluraflix.Videos.CreateTest do
  use Aluraflix.DataCase, async: true

  alias Aluraflix.Video
  alias Aluraflix.Videos.Create

  describe "create/1" do
    test "when all params are valid, then create a video record" do
      params = %{title: "video #01", description: "video 1...", url: "http://yt/video/1"}

      result = Create.call(params)

      assert {:ok,
              %Video{
                id: _id,
                title: "video #01",
                description: "video 1...",
                url: "http://yt/video/1"
              }} = result
    end

    test "when there are invalid params, then return a error message" do
      params = %{title: ".", description: ".", url: "yt/video/1"}

      result = Create.call(params)

      assert {:error,
              %{
                errors: [
                  {
                    :description,
                    {
                      "should be at least %{count} character(s)",
                      [
                        count: 3,
                        validation: :length,
                        kind: :min,
                        type: :string
                      ]
                    }
                  },
                  {:title,
                   {"should be at least %{count} character(s)",
                    [count: 3, validation: :length, kind: :min, type: :string]}}
                ]
              }} == result
    end

    test "when params is empty, then return a error message" do
      params = %{}

      result = Create.call(params)

      assert {:error,
              %{
                errors: [
                  {:title, {"can't be blank", [validation: :required]}},
                  {:description, {"can't be blank", [validation: :required]}},
                  {:url, {"can't be blank", [validation: :required]}}
                ]
              }} == result
    end
  end
end
