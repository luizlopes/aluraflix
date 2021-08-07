defmodule AluraflixWeb.VideosView do
  use AluraflixWeb, :view

  def render("index.json", %{videos: paginated_videos}) do
    %{
      _metadata:
        render(AluraflixWeb.PaginationView, "page.json",
          pagination: paginated_videos["pagination"]
        ),
      data:
        render_many(paginated_videos["result"], AluraflixWeb.VideosView, "video.json", as: :video)
    }
  end

  def render("show.json", %{video: video}) do
    %{data: render(AluraflixWeb.VideosView, "video.json", video: video)}
  end

  def render("video.json", %{video: video}) do
    %{
      id: video.id,
      title: video.title,
      description: video.description,
      url: video.url,
      categories:
        render_many(video.categories, AluraflixWeb.CategoriesView, "category.json", as: :category)
    }
  end
end
