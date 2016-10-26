defmodule CouchjitsuTrack.Oauth do
    alias Ueberauth.Auth
    alias CouchjitsuTrack.User

    def get_user(%Auth{} = auth) do
        user = auth
        |> get_oauth_token
        |> User.find_by_oauth
        |> IO.inspect

        case user do
            nil -> User.add(%User{oauth_token: get_oauth_token(auth), name: get_name(auth)})
            _ -> user
        end
    end

    defp get_oauth_token(auth) do
        "#{auth.provider}:#{auth.uid}"
    end

    defp get_name(auth) do
        if(auth.info.name) do
            auth.info.name
        else
            "#{auth.info.first_name} #{auth.info.last_name}"
        end
    end
end