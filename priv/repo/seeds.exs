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
# and so on) as they will fail if something goes wrong
alias ExatasHub.Repo
alias ExatasHub.Universities.University

Repo.insert!(%University{
  name: "Universidade Federal de Minas Gerais",
  initialism: "UFMG",
  logo: "https://logodownload.org/wp-content/uploads/2015/02/ufmg-logo-0.png"
})

Repo.insert!(%University{
  name: "Universidade de São Paulo",
  initialism: "USP",
  logo: "https://imagens.usp.br/wp-content/uploads/USP.jpg"
})

Repo.insert!(%University{
  name: "Universidade Federal de São Paulo",
  initialism: "Unifesp",
  logo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWi5Gr21_UiB8JSIN3vAxnkcGmGk_k7-gOsg&s"
})

Repo.insert!(%University{
  name: "Instituto de Matemática Pura e Aplicada",
  initialism: "IMPA",
  logo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYYhs7eiLcht5mDtbt0Vp0J1FnrFgzfA48OA&s"
})

Repo.insert!(%University{
  name: "Universidade de São Carlos",
  initialism: "UFScar",
  logo: "https://pbs.twimg.com/profile_images/1696229157603082243/jDBRIF1m_400x400.jpg"
})
