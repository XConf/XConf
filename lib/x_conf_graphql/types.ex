defmodule XConfGraphQL.Types do
  @moduledoc """
  The module to hold GraphQL type definitions.
  """
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  import_types XConfGraphQL.Type.ConferenceSchema

  node object :conference do
    field :code, non_null(:string)
    field :name, non_null(:string)
    field :speakers, list_of(:speaker)
  end
end
