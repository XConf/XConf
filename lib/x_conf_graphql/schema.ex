defmodule XConfGraphQL.Schema do
  @moduledoc """
  The GraphQL Schema, manifest of types and needed-to-resolve type references.
  """
  use Absinthe.Schema
  import_types XConfGraphQL.Types

  alias XConfGraphQL.Resolvers

  query do
    @desc "Get a conference"
    field :conference, :conference do
      arg :code, non_null(:string)
      resolve &Resolvers.get_conference_by_code/3
    end
  end
end
