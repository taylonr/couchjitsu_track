defmodule OauthTest do
    use ExUnit.Case

    import Mock

    alias CouchjitsuTrack.Oauth
    alias Ueberauth.Auth
    alias CouchjitsuTrack.User

    test "Should get the oauth_token from auth" do
        with_mock CouchjitsuTrack.User, [find_by_oauth: fn(_) -> %User{id: 1, oauth_token: "facebook:123"} end] do
            user = Oauth.get_user(%Auth{uid: 123, provider: "facebook"})
            assert user.oauth_token == "facebook:123"
        end
    end

    test "Should use the name field from info when supplied" do
        with_mock CouchjitsuTrack.User, [find_by_oauth: fn(_) -> %User{id: 1, name: "test"} end] do
            user = Oauth.get_user(%Auth{info: %Auth.Info{name: "test"}})
            assert user.name == "test"
        end
    end

    test "Should use first and last name when info.name is not supplied" do
        with_mock CouchjitsuTrack.User, [find_by_oauth: fn(_) -> %User{id: 1, name: "test tester"} end] do
            user = Oauth.get_user(%Auth{info: %Auth.Info{first_name: "test", last_name: "tester"}})
            assert user.name == "test tester"
        end
    end

    test "Should retrieve user if oauth_token exists in the database" do
        with_mock CouchjitsuTrack.User, [find_by_oauth: fn(_) -> %User{id: 1} end] do
            user = Oauth.get_user(%Auth{uid: 123, provider: "facebook"})
            assert user.id == 1
        end
    end

    test "Should create user if one is not found" do
        with_mock CouchjitsuTrack.User, [find_by_oauth: fn(_) -> nil end,
        add: fn(_) -> %User{id: 1} end] do
            user = Oauth.get_user(%Auth{uid: 123, provider: "facebook"})
            assert user.id == 1
        end
    end
end