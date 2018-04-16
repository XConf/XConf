defmodule XConf.Conf.SessionToLocation do
  use Ecto.Schema
  import Ecto.Changeset
  alias XConf.Conf.{Location, Session}

  @primary_key false
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
