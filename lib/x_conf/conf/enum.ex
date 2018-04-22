defmodule XConf.Conf.Enum do
  import EctoEnum, only: [defenum: 3]

  defenum SessionType, :session_type, [:session, :activity]
  defenum Language, :language, [:en, :"zh-TW"]
end
