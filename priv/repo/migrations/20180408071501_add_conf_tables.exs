defmodule XConf.Repo.Migrations.AddConfTables do
  use Ecto.Migration

  def change do
    create table(:sessions, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :type, :integer
      add :title, :string
      add :description, :string
      add :language, :integer
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
      add :bio, :string
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
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")

      timestamps()
    end

    alter table(:sessions) do
      add :speaker_id, references(:speakers, type: :uuid)
      add :conference_id, references(:conferences, type: :uuid)
    end

    alter table(:speakers) do
      add :conference_id, references(:conferences, type: :uuid)
    end

    alter table(:session_to_locations) do
      add :session_id, references(:sessions, type: :uuid)
      add :location_id, references(:locations, type: :uuid)
    end
  end
end
