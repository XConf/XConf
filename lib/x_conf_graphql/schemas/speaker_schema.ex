defmodule XConfGraphQL.SpeakerSchema do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  object :speaker do
    field :id, non_null(:string)
    field :name, non_null(:string)
    field :title, :string
    field :pictureUrl, non_null(:string), resolve: &(&1.picture_url)
    field :bio, :string
    field :homepageUrl, :string, resolve: &(&1.homepage_url)
    field :twitterUsername, :string, resolve: &(&1.twitter_username)
    field :githubUsername, :string, resolve: &(&1.github_username)
  end
end
