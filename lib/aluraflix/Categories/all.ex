defmodule Aluraflix.Categories.All do
  alias Aluraflix.{Repo, Category}

  def call() do
    Repo.all(Category)
  end
end
