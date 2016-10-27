defmodule CouchjitsuTrack.Record do
   use Ecto.Schema
   import Ecto.Changeset

   schema "records" do
       field :note
       field :duration, :float
       field :activity_id, :integer
       field :date, Ecto.Date
   end

   def changeset(record, params \\ %{}) do
       record
       |> cast(params, [:note, :duration, :activity_id, :date])
       |> validate_required([:duration, :activity_id, :date])
   end

   def add(record) do
       {:ok, created_record} = CouchjitsuTrack.Repo.insert(record)

       created_record
   end
end