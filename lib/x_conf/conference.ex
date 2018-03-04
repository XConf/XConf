defmodule XConf.Conference do
  use Ecto.Schema
  import Ecto.Changeset
  alias XConf.Conference

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "conferences" do
    field :code, :string
    field :name, :string

    timestamps
  end

  @doc false
  def changeset(%Conference{} = conference, attrs) do
    conference
    |> cast(attrs, [:code, :name])
    |> validate_required([:code, :name])
    |> unique_constraint(:code)
  end
end
