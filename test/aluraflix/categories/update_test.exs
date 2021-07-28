defmodule Aluraflix.Categories.UpdateTest do
  use Aluraflix.DataCase, async: true

  alias Aluraflix.Category
  alias Aluraflix.Categories.{Create, Update}

  describe "update/2" do
    test "Given an category, when all params are valid, then update a category record" do
      create_params = %{title: "category #01", color: "Grey"}

      {:ok, %Category{id: id} = category} = Create.call(create_params)

      update_params = %{
        title: "Updated category",
        color: "Purple"
      }

      result = Update.call(category, update_params)

      assert {:ok,
              %Category{
                id: ^id,
                title: "Updated category",
                color: "Purple"
              }} = result
    end

    test "Given an category, when there are invalid params, then return a error message" do
      create_params = %{title: "category #01", color: "Grey"}

      {:ok, %Category{} = category} = Create.call(create_params)

      update_params = %{title: ".", color: "."}

      {:error, result} = Update.call(category, update_params)

      assert %{
               color: ["should be at least 3 character(s)"],
               title: ["should be at least 3 character(s)"]
             } = errors_on(result)
    end
  end
end
