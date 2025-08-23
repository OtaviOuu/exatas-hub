# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ExatasHub.Repo.insert!(%ExatasHub.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ExatasHub.Repo
alias ExatasHub.Courses.Course
alias ExatasHub.Courses

c = %{
  title: "Introduction to Elixir",
  image: "https://downloadlynet.ir/wp-content/uploads/2024/12/Complete-web-development-course-C.jpg",
  university_logo: "https://images.seeklogo.com/logo-png/14/1/usp-logo-png_seeklogo-146733.png"
}

for _course <- 1..20 do
  Courses.create_course(%{
    title: c.title <> Integer.to_string(Enum.random(1..1000)),
    image: c.image,
    university_logo: c.university_logo
  })
end
