defmodule XConf.Conf.Speaker do
  use Ecto.Schema
  import Ecto.Changeset
  alias XConf.Conf.{Conference, Session}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "speakers" do
    field :name, :string
    field :title, :string
    field :picture_url, :string
    field :bio, :string
    field :homepage_url, :string
    field :twitter_username, :string
    field :github_username, :string

    belongs_to :conference, Conference
    has_many :sessions, Session

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = speaker, attrs) do
    speaker
    |> cast(attrs, [:name, :title, :picture_url, :bio, :homepage_url, :twitter_username, :github_username])
    |> validate_required([:name, :title])
  end
end
