defmodule XConf.Conf.Enum do
  import EctoEnum, only: [defenum: 2]

  defenum SessionType, session: "session", activity: "activity"
  defenum Language, en: "en", zh_tw: "zh-TW"
end
