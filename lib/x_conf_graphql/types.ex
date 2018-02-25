defmodule XConfGraphQL.Types do
  @moduledoc """
  The module to hold GraphQL type definitions.
  """
  use Absinthe.Schema.Notation

  object :conference do
    field :id, non_null(:id)
    field :code, non_null(:string)
    field :name, non_null(:string)
  end
end
