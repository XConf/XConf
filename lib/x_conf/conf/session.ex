
import EctoEnum, only: [defenum: 2]
defenum XConf.Conf.SessionType, SESSION: "session", ACTIVITY: "activity"
defenum XConf.Conf.Language, EN: "en", CHT: "zh"

defmodule XConf.Conf.Session do
  use Ecto.Schema
  import Ecto.Changeset
  alias XConf.Conf.{SessionType, Language, TimePeriod, Speaker, Conference, Location}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "sessions" do
    field :type, SessionType
    field :title, :string
    field :description, :string
    field :language, Language
    field :slide_url, :string
    field :video_url, :string

    embeds_one :time_period, TimePeriod
    belongs_to :speaker, Speaker
    belongs_to :conference, Conference
    many_to_many :locations, Location, join_through: "session_to_locations"

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = session, attrs) do
    session
    |> cast(attrs, [:type, :title, :description, :language, :slide_url, :video_url])
    |> validate_required([:type, :title, :description, :language])
  end
end
