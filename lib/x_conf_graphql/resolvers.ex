defmodule XConfGraphQL.Resolvers do
  @moduledoc """
  The module to hold GraphQL field resolvers.
  """
  alias XConf.Conference

  def get_conference(_parent, %{id: id}, _resolution) do
    case XConf.Repo.get_by(Conference, id: id) do
      nil ->
        {:error, "Conference with id \"#{id}\" not found."}
      conference ->
        {:ok, conference}
    end
  end

  def get_conference(_parent, %{code: code}, _resolution) do
    case XConf.Repo.get_by(Conference, code: code) do
      nil ->
        {:error, "Conference with code \"#{code}\" not found."}
      conference ->
        {:ok, conference}
    end
  end
end
