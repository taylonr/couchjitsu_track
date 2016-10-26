defmodule CouchjitsuTrack.Oauth do
    alias Ueberauth.Auth
    alias CouchjitsuTrack.User

    def get_user(%Auth{} = auth) do
        user = auth
        |> get_oauth_token
        |> User.find_by_oauth

        case user do
            nil -> User.add(auth)
            _ -> user
        end
    end

    def get_oauth_token(auth) do
        "#{auth.provider}:#{auth.uid}"
    end
end