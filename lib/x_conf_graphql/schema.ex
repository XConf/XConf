defmodule XConfGraphQL.Schema do
  @moduledoc """
  The GraphQL Schema, manifest of types and needed-to-resolve type references.
  """
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  import_types XConfGraphQL.Types

  alias XConfGraphQL.Resolvers

  node interface do
    resolve_type fn
      %XConf.Conference{}, _ ->
        :conference
      _, _ ->
        nil
    end
  end

  query do
    node field do
      resolve fn
        %{type: :conference, id: id}, _ ->
          Resolvers.get_conference(nil, %{id: id}, nil)
        _, _ ->
          {:error, "Malformed global ID."}
      end
    end

    @desc "Get a conference"
    field :conference, :conference do
      arg :code, non_null(:string)
      resolve &Resolvers.get_conference/3
    end
  end
end
