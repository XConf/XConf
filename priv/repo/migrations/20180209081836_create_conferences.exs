defmodule XConf.Repo.Migrations.CreateConferences do
  use Ecto.Migration

  def change do
    create table(:conferences, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")

      add :code, :string, null: false
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:conferences, [:code])
  end
end
