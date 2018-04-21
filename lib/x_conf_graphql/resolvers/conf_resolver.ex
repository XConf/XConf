defmodule XConfGraphQL.ConfResolvers do
  @moduledoc """
  The module to hold GraphQL field resolvers.
  """
  alias XConf.Conf

  def get_conference(_parent, %{id: id}, _resolution) do
    case Conf.get_conference(id) do
      nil ->
        {:error, "Conference with id \"#{id}\" not found."}
      conference ->
        {:ok, conference}
    end
  end

  def get_conference(_parent, %{code: code}, _resolution) do
    case Conf.get_conference(code: code) do
      nil ->
        {:error, "Conference with code \"#{code}\" not found."}
      conference ->
        {:ok, conference}
    end
  end
end
