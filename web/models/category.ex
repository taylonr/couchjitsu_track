defmodule CouchjitsuTrack.Category do
  use CouchjitsuTrack.Web, :model

  import Ecto.Changeset

  schema "categories" do
    field :name, :string
    belongs_to :user, CouchjitsuTrack.User
    has_many :activities, CouchjitsuTrack.Activity
    timestamps()
  end

  @required ~w(name user_id)
  @optional ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required, @optional)
    |> validate_required([:name])
  end
end
