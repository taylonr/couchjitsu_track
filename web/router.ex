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

    get "/activity/:id", ActivityController, :index

    get "/statistics", StatisticsController, :index
  end
  scope "/activityfeed", CouchjitsuTrack do
    pipe_through :browser

    get "/", ActivityFeedController, :index
    get "/new", ActivityFeedController, :new
    post "/new", ActivityFeedController, :create
    delete "/:record_id", ActivityFeedController, :delete
  end

  scope "/auth", CouchjitsuTrack do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  scope "/user", CouchjitsuTrack do
    pipe_through :browser

    get "/", UserController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", CouchjitsuTrack do
  #   pipe_through :api
  # end
end
