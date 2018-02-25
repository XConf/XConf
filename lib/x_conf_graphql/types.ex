defmodule XConfGraphQL.Types do
  @moduledoc """
  The module to hold GraphQL type definitions.
  """
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  node object :conference do
    field :code, non_null(:string)
    field :name, non_null(:string)
  end
end
