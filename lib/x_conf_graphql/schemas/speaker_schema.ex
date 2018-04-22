defmodule XConfGraphQL.SpeakerSchema do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  object :speaker do
    field :id, non_null(:string)
    field :name, non_null(:string)
    field :title, :string
    field :picture_url, non_null(:string)
    field :bio, :string
    field :homepage_url, :string
    field :twitter_username, :string
    field :github_username, :string
  end
end
