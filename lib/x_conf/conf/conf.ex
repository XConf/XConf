defmodule XConf.Conf do

  alias XConf.Repo

  alias XConf.Conf
  alias Conf.Conference

  def get_conference(id, opts \\ []) do
    Repo.get(Conference, id, opts)
  end
end
