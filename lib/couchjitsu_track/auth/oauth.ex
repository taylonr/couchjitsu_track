defmodule CouchjitsuTrack.Oauth do
    alias Ueberauth.Auth

    def get_user(%Auth{} = auth) do
        %{id: auth.uid, provider: auth.provider, name: get_name(auth.info)}
    end

    defp get_name(%Auth.Info{} = info) do
        if(info.name) do
            info.name
        else
            "#{info.first_name} #{info.last_name}"
        end

    end

end