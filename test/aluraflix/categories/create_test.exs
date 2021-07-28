defmodule Aluraflix.Categories.CreateTest do
  use Aluraflix.DataCase, async: true

  alias Aluraflix.Category
  alias Aluraflix.Categories.Create

  describe "create/1" do
    test "when all params are valid, then create a category record" do
      params = %{title: "category #01", color: "black"}

      result = Create.call(params)

      assert {:ok,
              %Category{
                id: _id,
                title: "category #01",
                color: "black"
              }} = result
    end

    test "when there are invalid params, then return a error message" do
      params = %{title: ".", color: "."}

      {:error, result} = Create.call(params)

      assert %{
               color: ["should be at least 3 character(s)"],
               title: ["should be at least 3 character(s)"]
             } = errors_on(result)
    end

    test "when params is empty, then return a error message" do
      params = %{}

      {:error, result} = Create.call(params)

      assert %{
               title: ["can't be blank"],
               color: ["can't be blank"]
             } = errors_on(result)
    end
  end
end
