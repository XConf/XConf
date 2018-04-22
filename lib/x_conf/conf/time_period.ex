defmodule XConf.Conf.TimePeriod do
  use Ecto.Schema

  embedded_schema do
    field :start, :naive_datetime
    field :peroid, :integer # in seconds
  end
end
