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
