defmodule CouchjitsuTrack.Record do
   use Ecto.Schema

   schema "records" do
       field :note
       field :duration, :float
       field :activity_id, :integer
       field :date, Ecto.DateTime
   end
end