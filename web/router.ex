defmodule CouchjitsuTrack.Router do
  use CouchjitsuTrack.Web, :router

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

  scope "/", CouchjitsuTrack do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index



    get "/activityfeed", ActivityHistoryController, :index
    get "/activityfeed/new", ActivityHistoryController, :new
    get "/activity/:id", ActivityController, :index
  end

  scope "/auth", CouchjitsuTrack do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", CouchjitsuTrack do
  #   pipe_through :api
  # end
end
