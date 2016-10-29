defmodule CouchjitsuTrack.Repo.Migrations.AlterTimestampToDate do
  use Ecto.Migration

  def change do
    alter table(:records) do
      modify :date, :date
    end
  end
end
