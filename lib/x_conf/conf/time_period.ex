defmodule XConf.Conf.TimePeriod do
  use Ecto.Schema

  embedded_schema do
    field :start
    field :peroid
  end
end
