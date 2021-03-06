defmodule XConfGraphQL.ConferenceSchema do
  @moduledoc """
  The module to hold GraphQL type definitions.
  """
  use Absinthe.Ecto, repo: XConf.Repo
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  import_types XConfGraphQL.SpeakerSchema
  import_types XConfGraphQL.SessionSchema

  node object :conference do
    field :code, non_null(:string)
    field :name, non_null(:string)
    field :speakers, list_of(:speaker), resolve: assoc(:speakers)
    field :sessions, list_of(:session), resolve: assoc(:sessions)
  end
end
