defmodule XConf.Conf.Location do
  use Ecto.Schema
  import Ecto.Changeset
  alias XConf.Conf.{Session}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "locations" do
    field :name, :string
    field :map_image_url, :string

    many_to_many :sessions, Session, join_through: "session_to_locations"

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = location, attrs) do
    location
    |> cast(attrs, [:name, :map_image_url])
    |> validate_required([:name])
  end
end
