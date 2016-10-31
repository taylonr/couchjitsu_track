defmodule CouchjitsuTrack.Record do
   use Ecto.Schema
   import Ecto.Changeset

   schema "records" do
       field :note
       field :duration, :float
       field :activity_id, :integer
       field :date, Ecto.Date
   end

   @required_fields ~w(duration activity_id date)
   @optional_fields ~w(note)

   def changeset(record, params \\ %{}) do
       record
       |> cast(params, @required_fields, @optional_fields)
       |> validate_required([:duration, :activity_id, :date])
   end

   def add(record) do
       CouchjitsuTrack.Repo.insert(record)
   end

   def delete(id) do
       {record_id, _} = Integer.parse(id)
       record = CouchjitsuTrack.Repo.get(__MODULE__, record_id)
       CouchjitsuTrack.Repo.delete(record)
   end
end