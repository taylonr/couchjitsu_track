defmodule CouchjitsuTrack.Repo.Migrations.AddCategoryToActivities do
  use Ecto.Migration

  def change do
    alter table(:activities) do
      add :category_id, references(:categories, on_delete: :nothing)
    end
  end
end
