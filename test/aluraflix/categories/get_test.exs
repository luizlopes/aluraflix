defmodule Aluraflix.Categories.GetTest do
  use Aluraflix.DataCase, async: true

  alias Aluraflix.Category
  alias Aluraflix.Categories.Get

  describe "call/1" do
    test "when id doesn't exist, then return error with not_found status" do
      id = 345
      result = Get.call(%{"id" => id})

      assert {:error, :not_found} = result
    end

    test "when id exists, then return ok with category record" do
      params = %{title: "category #01", color: "Green"}

      {:ok, %Category{id: id}} =
        params
        |> Category.changeset()
        |> Repo.insert()

      result = Get.call(%{"id" => id})

      assert {:ok,
              %Category{
                id: ^id,
                title: "category #01",
                color: "Green"
              }} = result
    end
  end
end
