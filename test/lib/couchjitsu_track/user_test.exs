defmodule UserTest do
    use ExUnit.Case

    alias CouchjitsuTrack.User

    test "Changeset should fail if name is not supplied" do
        %{errors: errors} = User.changeset(%User{})
        assert Keyword.fetch(errors, :name) != :error
    end

    test "Changeset should fail if oauth_token is not supplied" do
        %{errors: errors} = User.changeset(%User{})
        assert Keyword.fetch(errors, :oauth_token) != :error
    end
end