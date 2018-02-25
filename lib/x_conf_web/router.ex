defmodule XConfWeb.Router do
  use XConfWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", XConfWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/graphql" do
    pipe_through :api

    forward "/", Absinthe.Plug, schema: XConfGraphQL.Schema
  end

  # Other scopes may use custom stacks.
  # scope "/api", XConfWeb do
  #   pipe_through :api
  # end
end
