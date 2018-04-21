defmodule XConfGraphQL.SessionSchema do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: XConf.Repo

  import_types XConfGraphQL.Type.ConferenceSchema
  import_types XConfGraphQL.Enum

  object :session do
    field :id, non_null(:string)
    field :title, non_null(:string)
    field :description, non_null(:string)
    field :speaker, non_null(:speaker), resolve: assoc(:speaker)
    field :speakerId, non_null(:string), resolve: &({:ok, &1.speaker_id})
    field :language, non_null(:language)
    field :slideUrl, :string, resolve: &({:ok, &1.slide_url})
    field :videoUrl, :string, resolve: &({:ok, &1.video_url})
  end
end
