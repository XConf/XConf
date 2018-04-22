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
alias XConf.Conf.{Conference, Speaker, Session, Location, TimePeriod}

IO.puts "== Preparing Conference Data =="
conf_code = "rubyelixirconf-2018"
conf_name = "Ruby x Elixir conf 2018"

defmodule Helper do
  def time_period(date, start, end_time) do
    {
      parse_yml_time!(date, start),
      parse_yml_time!(date, end_time)
    }
    |> build_time_period()
  end

  defp build_time_period({start, end_time}) do
    %TimePeriod{
      start: start,
      peroid: DateTime.diff(end_time, start)
    }
  end

  defp parse_yml_time!(date, time_str) do
    if Regex.match?(~r/pm$/, time_str) do
      43200
    else
      0
    end
    |> (&Time.add(parse_yml_time_with_apm(time_str), &1)).()
    |> Time.to_iso8601()
    |> (&DateTime.from_iso8601("#{date}T#{&1}Z")).()
    |> case do
      {:ok, datetime, 0} -> datetime
      _ -> raise "unable to parse date time"
    end
  end

  defp parse_yml_time_with_apm(time_str) do
    String.replace(time_str, ~r/ (p|a)m$/, "")
    |> String.pad_leading(5, "0")
    |> (&Time.from_iso8601!("#{&1}:00")).()
  end
end

conference =
  Repo.get_by(Conference, code: conf_code) || %Conference{}
  |> Conference.changeset(%{code: conf_code, name: conf_name})
  |> Repo.insert_or_update!()

language_mapping = %{"EN" => :en, "CHT" => :"zh-TW"}

locations =
  Enum.map(["1001 Auditorium", "1002 Auditorium", "1003 Auditorium"], fn(name) ->
    Repo.get_by(Location, name: name) || %Location{}
    |> Location.changeset(%{name: name})
    |> Repo.insert_or_update!()
  end)

session_speakers =
  System.argv()
  |> case do
    [speaker_yml_path, program_yml_path] ->
      {activities, period_locations} =
        YamlElixir.read_from_file(program_yml_path)
        |> case do
          {:ok, %{"dayOne" => day1_schedule, "dayTwo" => day2_schedule}} ->
            [
              {day1_schedule, "2018-04-27", "7:30 pm"},
              {day2_schedule, "2018-04-28", "5:30 pm"},
            ]
            |> Enum.flat_map(fn{schedule, date, day_end_time} ->
              Enum.zip(
                schedule,
                List.delete_at(schedule, 0) ++ [%{"period" => day_end_time}]
              )
              |> Enum.map(fn
                {%{"period" => start, "agenda" => name}, %{"period" => end_time}} ->
                  {[{nil, %{type: :activity, title: name}, {Helper.time_period(date, start, end_time), locations}}], []}
                {%{"period" => start, "speakerOne" => speaker1, "speakerTwo" => speaker2, "speakerThree" => speaker3}, %{"period" => end_time}} ->
                  {[], [
                    {speaker1, {Helper.time_period(date, start, end_time), Enum.slice(locations, 0, 1)}},
                    {speaker2, {Helper.time_period(date, start, end_time), Enum.slice(locations, 1, 1)}},
                    {speaker3, {Helper.time_period(date, start, end_time), Enum.slice(locations, 2, 1)}},
                  ]}
                {%{"period" => start, "speakerOne" => speaker}, %{"period" => end_time}} -> {[], [{speaker, {Helper.time_period(date, start, end_time), locations}}]}
              end)
            end)
            |> Enum.unzip()
            |> (fn{activities, period_locations} -> {
              List.flatten(activities),
              List.flatten(period_locations) |> Map.new()
            } end).()
          err ->
            IO.inspect(:stderr, err, [])
            {[], %{}}
        end

      YamlElixir.read_from_file(speaker_yml_path)
      |> case do
        {:ok, yml_data} ->
          Enum.map(yml_data, fn(data) -> {data, Map.get(data, "avatar", "")} end)
          |> Enum.map(fn
            {data, ""} -> {data, ""}
            {data, avatar = "http" <> _} -> {data, avatar}
            {data, avatar} -> {data, "https://2018.rubyconf.tw/images/#{avatar}"}
          end)
          |> Enum.map(fn{data = %{"name" => name}, picture_url} ->
              {
                %{
                  name: name,
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
                },
                Map.fetch!(period_locations, name),
              }
          end)
        err -> IO.inspect(:stderr, err, [])
      end
      |> Kernel.++(activities)
    [] ->
      IO.puts("== using self default speaker and session ==")
      [
        {
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
          },
          {Helper.time_period("2018-04-28", "4:15 pm", "5:15 pm"), locations}
        },
        {
          nil,
          %{type: :activity, title: "Registration"},
          {Helper.time_period("2018-04-27", "9:00 am", "9:50 am"), locations}
        },
      ]
  end

session_speakers
|> Enum.map(fn
  ({nil, _, {_, _}} = session_speaker) -> session_speaker
  ({speaker_data, _, {_, _}} = session_speaker) ->
    Repo.one(
      from s in Speaker, preload: :conference, where: s.name == ^speaker_data.name and s.conference_id == ^conference.id
    )
    |> Kernel.||(%Speaker{})
    |> Speaker.changeset(speaker_data)
    |> Changeset.put_assoc(:conference, conference)
    |> Repo.insert_or_update!()
    |> (&put_elem(session_speaker, 0, &1)).()
end)
|> Enum.map(fn({speaker, session_data, {time_period, locations}} = session_speaker) ->
  Repo.one(
    from s in Session,
    preload: [:speaker, :conference, :locations],
    where: s.title == ^session_data.title and s.conference_id == ^conference.id,
    where: fragment("(time_period->'start')::jsonb") == ^DateTime.to_iso8601(time_period.start)
  )
  |> Kernel.||(%Session{})
  |> Session.changeset(session_data)
  |> Changeset.put_embed(:time_period, time_period)
  |> Changeset.put_assoc(:conference, conference)
  |> Changeset.put_assoc(:locations, locations)
  |> (&{&1, speaker}).()
end)
|> Enum.each(fn
  {session, nil} ->
    Repo.insert_or_update!(session)
  {session, speaker} ->
    Changeset.put_assoc(session, :speaker, speaker)
    |> Repo.insert_or_update!()
end)

IO.puts("== seeded #{length(session_speakers)} session_speakers ==")

IO.puts "Database Seeded!"
