defmodule XConfGraphQL.Resolvers do
  @moduledoc """
  The module to hold GraphQL field resolvers.
  """
  alias XConf.Conference

  def get_conference_by_code(_parent, %{code: code}, _resolution) do
    case XConf.Repo.get_by(Conference, code: code) do
      nil ->
        {:error, "Conference code \"#{code}\" not found"}
      conference ->
        {:ok, conference}
    end
  end
end
