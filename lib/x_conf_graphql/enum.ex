defmodule XConfGraphQL.Enum do
  use Absinthe.Schema.Notation

  enum :language do
    value :en
    value :"zh-TW", as: :zh_tw
  end
end
