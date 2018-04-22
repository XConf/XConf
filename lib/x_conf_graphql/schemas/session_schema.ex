defmodule XConfGraphQL.SessionSchema do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: XConf.Repo

  import_types XConfGraphQL.SpeakerSchema
  import_types XConfGraphQL.Enum

  object :session do
    field :id, non_null(:string)
    field :title, non_null(:string)
    field :description, non_null(:string)
    field :speaker, non_null(:speaker), resolve: assoc(:speaker)
    field :speaker_id, non_null(:string)
    field :language, non_null(:language)
    field :slide_url, :string
    field :video_url, :string
  end
end
