defmodule XConf.Conf.TimePeriod do
  use Ecto.Schema

  embedded_schema do
    field :start, :naive_datetime
    field :peroid, :naive_datetime
  end
end
