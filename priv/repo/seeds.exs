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

alias XConf.Repo
import Ecto.Query, only: [from: 2]
alias Ecto.Changeset
alias XConf.Conf.{Conference, Speaker, Session}

IO.puts "== Preparing Conference Data =="
conf_code = "rubyelixirconf-2018"
conf_name = "Ruby x Elixir conf 2018"

conference =
  Repo.get_by(Conference, code: conf_code) || %Conference{}
  |> Conference.changeset(%{code: conf_code, name: conf_name})
  |> Repo.insert_or_update!()

language_mapping = %{"EN" => :en, "CHT" => :"zh-TW"}

session_speakers =
  System.argv()
  |> case do
    [speaker_yml_path] ->
      YamlElixir.read_from_file(speaker_yml_path)
      |> case do
        {:ok, yml_data} ->
          Enum.map(yml_data, fn(data) -> {data, Map.get(data, "avatar", "")} end)
          |> Enum.map(fn
            {data, ""} -> {data, ""}
            {data, avatar = "http" <> _} -> {data, avatar}
            {data, avatar} -> {data, "https://2018.rubyconf.tw/images/#{avatar}"}
          end)
          |> Enum.map(fn{data, picture_url} ->
              {
                %{
                  name: Map.get(data, "name", ""),
                  title: Map.get(data, "title", ""),
                  picture_url: picture_url,
                  bio: Map.get(data, "bio", ""),
                  homepage_url: Map.get(data, "urlHome", ""),
                  twitter_username: (Map.get(data, "urltwitter") || Map.get(data, "urlTwitter") || "") |> String.replace(~r[^https?://twitter.com/], ""),
                  github_username: Map.get(data, "urlGithub", "") |> String.replace(~r[^https?://github.com/], ""),
                },
                %{
                  type: :session,
                  title: Map.get(data, "subject", ""),
                  description: Map.get(data, "summary", ""),
                  language: Map.get(data, "lang", "CHT") |> String.upcase() |> (&Map.get(language_mapping, &1, "en")).(),
                  slide_url: "",
                  video_url: "",
                }
              }
          end)
        err -> IO.inspect(:stderr, err, [])
      end
    [] ->
      IO.puts("== using self default speaker and session ==")
      [{
        %{
          name: "José Valim",
          title: "Creator of Elixir, Plataformatec",
          picture_url: "https://2018.rubyconf.tw/images/speakers/jose-valim.jpg",
          bio: "Plataformatec co-founder and creator of Elixir Lang. I have signed off from Twitter indefinitely, RTs are automated.",
          homepage_url: "",
          twitter_username: "josevalim",
          github_username: "josevalim",
        },
        %{
          type: :session,
          title: "Idioms for building distributed fault-tolerant applications with Elixir",
          description: "This talk will introduce developers to Elixir and the underlying Erlang VM and show how they provide a new vocabulary which shapes how developers design and build concurrent, distributed and fault-tolerant applications. The talk will also focus on the design goals behind Elixir and include some live demos.",
          language: :en,
          slide_url: "",
          video_url: "",
        }
      }]
  end

session_speakers
|> Enum.each(fn{speaker_data, session_data} ->
  speaker =
    Repo.one(
      from s in Speaker, preload: :conference, where: s.name == ^speaker_data.name and s.conference_id == ^conference.id
    )
    |> Kernel.||(%Speaker{})
    |> Speaker.changeset(speaker_data)
    |> Changeset.put_assoc(:conference, conference)
    |> Repo.insert_or_update!()

  Repo.one(
    from s in Session,
    preload: [:speaker, :conference],
      where: s.title == ^session_data.title and s.conference_id == ^conference.id and s.speaker_id == ^speaker.id
  )
  |> Kernel.||(%Session{})
  |> Session.changeset(session_data)
  |> Changeset.put_assoc(:speaker, speaker)
  |> Changeset.put_assoc(:conference, conference)
  |> Repo.insert_or_update!()
end)

IO.puts("== seeded #{length(session_speakers)} session_speakers ==")

IO.puts "Database Seeded!"
