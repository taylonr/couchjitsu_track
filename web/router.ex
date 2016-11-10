defmodule CouchjitsuTrack.Router do
  use CouchjitsuTrack.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticated do
    plug :browser
    plug CouchjitsuTrack.Plugs.RequireAuthentication
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug CouchjitsuTrack.Plugs.RequireAuthentication
  end

  scope "/", CouchjitsuTrack do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/auth", CouchjitsuTrack do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  scope "/activity", CouchjitsuTrack do
    pipe_through :authenticated

    get "/:id", ActivityController, :index
  end

  scope "/statistics", CouchjitsuTrack do
    pipe_through :authenticated

    get "/", StatisticsController, :index
  end

  scope "/activityfeed", CouchjitsuTrack do
    pipe_through :authenticated

    get "/", ActivityFeedController, :index
    get "/new", ActivityFeedController, :new
    post "/new", ActivityFeedController, :create
    delete "/:record_id", ActivityFeedController, :delete
  end

  scope "/user", CouchjitsuTrack do
    pipe_through :authenticated

    get "/", UserController, :index
    post "/", UserController, :create
  end

  # Other scopes may use custom stacks.
  scope "/api", CouchjitsuTrack do
    pipe_through :api

    get "/statistics", StatisticsController, :statistics
  end
end
