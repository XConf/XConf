defmodule XConfGraphQL.Schema do
  @moduledoc """
  The GraphQL Schema, manifest of types and needed-to-resolve type references.
  """
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern
  alias XConf.Conf.Conference

  import_types XConfGraphQL.ConferenceSchema

  alias XConfGraphQL.ConfResolver

  node interface do
    resolve_type fn
      %Conference{}, _ ->
        :conference
      _, _ ->
        nil
    end
  end

  query do
    node field do
      resolve fn
        %{type: :conference, id: id}, _ ->
          ConfResolver.get_conference(nil, %{id: id}, nil)
        _, _ ->
          {:error, "Malformed global ID."}
      end
    end

    @desc "Get a conference"
    field :conference, :conference do
      arg :code, non_null(:string)
      resolve &ConfResolver.get_conference/3
    end
  end
end
