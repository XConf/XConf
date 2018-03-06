defmodule XConf.Conf.SessionToLocation do
  use Ecto.Schema
  import Ecto.Changeset
  alias XConf.Conf.{Location, Session}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "session_to_locations" do
    belongs_to :location, Location
    belongs_to :session, Session

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = session_to_location, attrs) do
    session_to_location
    |> cast(attrs, [])
    |> validate_required([])
  end
end
