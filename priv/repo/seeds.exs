# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     XConf.Repo.insert!(%XConf.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias XConf.{Repo, Conference}

IO.puts "== Preparing Conference Data =="

Repo.get_by(Conference, code: "rubyconf-2016") || %Conference{}
  |> Conference.changeset(%{code: "rubyconf-2016", name: "RubyConf 2016"})
  |> Repo.insert_or_update!()

IO.puts "Database Seeded!"
