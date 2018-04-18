defmodule XConf.Conf do

  alias XConf.Repo

  alias XConf.Conf
  alias Conf.Conference

  def get_conference(clause = [_]) do
    Repo.get_by(Conference, clause)
  end

  def get_conference(id) do
    Repo.get(Conference, id)
  end
end
