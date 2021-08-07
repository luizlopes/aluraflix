defmodule Aluraflix.Factory do
  alias Aluraflix.{Repo, Video, Category, VideoCategory}

  def build(:category) do
    %Category{title: "Thriller", color: "Orange"}
  end

  def build(:video) do
    %Video{
      title: "video #01",
      description: "video 1...",
      url: "http://yt/video/1",
      categories: []
    }
  end

  def build(:video_category) do
    %VideoCategory{video_id: 1, category_id: 1}
  end

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
