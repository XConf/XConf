defmodule XConfGraphQL.Enum do
  use Absinthe.Schema.Notation

  enum :language do
    value :en
    value :zhtw, as: :"zh-TW"
  end
end
