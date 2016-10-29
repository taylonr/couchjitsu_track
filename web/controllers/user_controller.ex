defmodule CouchjitsuTrack.UserController do
    use CouchjitsuTrack.Web, :controller

    plug CouchjitsuTrack.Plugs.RequireAuthentication
    
    def index(conn, _params) do
        render conn, "index.html"
    end
end