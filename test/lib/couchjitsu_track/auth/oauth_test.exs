defmodule OauthTest do
    use ExUnit.Case
    alias CouchjitsuTrack.Oauth
    alias Ueberauth.Auth

    test "Should get the ID from auth" do
        user = Oauth.get_user(%Auth{uid: 123})
        assert user.id == 123
    end

    test "Should get the provider" do
        user = Oauth.get_user(%Auth{provider: "facebook"})
        assert user.provider == "facebook"
    end

    test "Should use the name field from info when supplied" do
        user = Oauth.get_user(%Auth{info: %Auth.Info{name: "test"}})
        assert user.name == "test"
    end

    test "Should use first and last name when info.name is not supplied" do
        user = Oauth.get_user(%Auth{info: %Auth.Info{first_name: "test", last_name: "tester"}})
        assert user.name == "test tester"
    end
end