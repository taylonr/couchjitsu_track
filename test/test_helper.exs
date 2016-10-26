ExUnit.start

Mix.Task.run "ecto.create", ~w(-r CouchjitsuTrack.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r CouchjitsuTrack.Repo --quiet)
Ecto.Adapters.SQL.Sandbox.mode(CouchjitsuTrack.Repo, :manual)
