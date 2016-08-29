defmodule CouchjitsuTrack.Repo.Migrations.CreateActivity do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :name, :string
      add :default_duration, :float
      add :user_id, :integer

      timestamps
    end

  end
end
