defmodule XConf.Conf.Enums do
  import EctoEnum, only: [defenum: 2]

  defenum SessionType, session: "session", activity: "activity"
  defenum Language, en: "en", zh_tw: "zh-tw"
end
