defmodule Aluraflix.PaginationTest do
  use Aluraflix.DataCase, async: true
  import Aluraflix.Factory

  alias Aluraflix.{Video, Pagination}

  setup do
    category = insert!(:category, %{title: "category #01", color: "blank"})

    videos = Enum.map(1..25, fn number -> insert!(:video, %{title: "video #{number}"}) end)

    Enum.each(videos, fn video ->
      insert!(:video_category, %{video_id: video.id, category_id: category.id})
    end)

    {:ok, videos: videos}
  end

  describe "paginate/1" do
    test "when query return all videos, then paginate items according to default parameters" do
      paginated_items = Pagination.paginate(Video)

      assert %{
               "pagination" => %{
                 "page" => 1,
                 "per_page" => 5,
                 "page_count" => 5,
                 "total_count" => 25
               },
               "result" => result
             } = paginated_items

      assert length(result) == 5
    end
  end

  describe "paginate/2" do
    test "when query return all videos, then paginate items according to parameters" do
      paginated_items = Pagination.paginate(Video, page: 2, per_page: 10)

      assert %{
               "pagination" => %{
                 "page" => 2,
                 "per_page" => 10,
                 "page_count" => 3,
                 "total_count" => 25
               },
               "result" => result
             } = paginated_items

      assert length(result) == 10
    end
  end

  test "when query return all videos and paginate is over valued, then paginate items according to parameters" do
    paginated_items = Pagination.paginate(Video, page: 2, per_page: 30)

    assert %{
             "pagination" => %{
               "page" => 2,
               "per_page" => 30,
               "page_count" => 1,
               "total_count" => 25
             },
             "result" => []
           } = paginated_items
  end
end
