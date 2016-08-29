defmodule CouchjitsuTrack.ActivityTest do
  use CouchjitsuTrack.ModelCase

  alias CouchjitsuTrack.Activity

  @valid_attrs %{default_duration: "120.5", name: "some content", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Activity.changeset(%Activity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Activity.changeset(%Activity{}, @invalid_attrs)
    refute changeset.valid?
  end
end
