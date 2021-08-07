defmodule AluraflixWeb.PaginationView do
  use AluraflixWeb, :view

  def render("page.json", %{pagination: pagination}) do
    %{
      page: pagination["page"],
      page_count: pagination["page_count"],
      per_page: pagination["per_page"],
      total_count: pagination["total_count"]
    }
  end
end
