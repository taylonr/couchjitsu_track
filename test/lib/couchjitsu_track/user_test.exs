defmodule UserTest do
    use ExUnit.Case

    import Mock

    alias CouchjitsuTrack.User

    test "Changeset should fail if name is not supplied" do
        %{errors: errors} = User.changeset(%User{})
        assert Keyword.fetch(errors, :name) != :error
    end

    test "Changeset should fail if oauth_token is not supplied" do
        %{errors: errors} = User.changeset(%User{})
        assert Keyword.fetch(errors, :oauth_token) != :error
    end

    test "Adding a user should insert it into the database" do
        with_mock CouchjitsuTrack.Repo,[insert: fn(_) -> {:ok, %User{id: 1}} end] do
            user = User.add(%User{name: "test", oauth_token: "test"})
            assert user.id == 1
        end
    end
end