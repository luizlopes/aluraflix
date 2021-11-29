params_videos = %{title: "video #01", description: "video 1...", url: "http://yt/video/1"}

Aluraflix.Videos.Create.call(params_videos)


params_categories = %{title: "category #010", color: "white"}

Aluraflix.Categories.Create.call(params_categories)


{:ok, video} = Aluraflix.Videos.Get.call(%{"id" => 1})

video = Aluraflix.Repo.preload(video, [:categories])


{:ok, category} = Aluraflix.Categories.Get.call(%{"id" => 2})
category = Aluraflix.Repo.preload(category, [:videos])


video_changeset = Ecto.Changeset.change(video)

video_changeset |> Ecto.Changeset.put_assoc(:categories, [category]) |> Aluraflix.Repo.update




## Inserting on videos_categories table

params_vc = %{video_id: 1, category_id: 2}
params_vc = %{video_id: 2, category_id: 1}
params_vc |> Aluraflix.VideoCategory.changeset |> Aluraflix.Repo.insert


## Getting Videos by Category

query = from c in Category,
join: v in assoc(c, :videos)
where: c.id == 1,
select: %{video: v}
preload: 

SELECT v1."id", v1."title", v1."description", v1."url", v1."inserted_at", v1."updated_at" 
FROM "categories" AS c0 
INNER JOIN "videos_categories" AS v2 ON v2."category_id" = c0."id" 
INNER JOIN "videos" AS v1 ON v2."video_id" = v1."id" WHERE (c0."id" = 1) []

##

q3 = from v in Video,
join: c in assoc(v, :categories),
where: c.id == 1

