defmodule AluraflixWeb.CategoriesView do
  use AluraflixWeb, :view

  def render("index.json", %{categories: categories}) do
    %{data: render_many(categories, AluraflixWeb.CategoriesView, "category.json", as: :category)}
  end

  def render("show.json", %{category: category}) do
    %{data: render(AluraflixWeb.CategoriesView, "category.json", category: category)}
  end

  def render("category.json", %{category: category}) do
    %{id: category.id, title: category.title, color: category.color}
  end
end
