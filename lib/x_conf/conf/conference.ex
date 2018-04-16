defmodule XConf.Conf.Conference do
  use Ecto.Schema
  import Ecto.Changeset
  alias XConf.Conf.{Speaker, Session}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "conferences" do
    field :code, :string
    field :name, :string

    has_many :speakers, Speaker
    has_many :sessions, Session

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = conference, attrs) do
    conference
    |> cast(attrs, [:code, :name])
    |> validate_required([:code, :name])
    |> unique_constraint(:code)
  end
end
