defmodule XConf.Repo.Migrations.AddConfTables do
  use Ecto.Migration

  def change do
    create table(:sessions, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :type, :string
      add :title, :string
      add :description, :text
      add :language, :string
      add :slide_url, :string
      add :video_url, :string
      add :time_period, :jsonb

      timestamps()
    end

    create table(:speakers, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :name, :string
      add :title, :string
      add :picture_url, :string
      add :bio, :text
      add :homepage_url, :string
      add :twitter_username, :string
      add :github_username, :string

      timestamps()
    end

    create table(:locations, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :name, :string
      add :map_image_url, :string

      timestamps()
    end

    create table(:session_to_locations, primary_key: false) do
      add :session_id, references(:sessions, type: :uuid)
      add :location_id, references(:locations, type: :uuid)
    end

    alter table(:sessions) do
      add :speaker_id, references(:speakers, type: :uuid)
      add :conference_id, references(:conferences, type: :uuid)
    end

    alter table(:speakers) do
      add :conference_id, references(:conferences, type: :uuid)
    end
  end
end
