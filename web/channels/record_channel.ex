defmodule CouchjitsuTrack.RecordChannel do
  use CouchjitsuTrack.Web, :channel

  def join("records:" <> user_id, payload, socket) do
      {:ok, "Joined records:#{user_id}", socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  # def handle_in("ping", payload, socket) do
  #   {:reply, {:ok, payload}, socket}
  # end

  # # It is also common to receive messages from the client and
  # # broadcast to everyone in the current topic (as:lobby).
  # def handle_in("shout", payload, socket) do
  #   broadcast socket, "shout", payload
  #   {:noreply, socket}
  # end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("add", payload, socket) do
    IO.puts "Add"
    IO.inspect {:reply, {:ok, payload}, socket}
    # push socket, "add", payload
    {:reply, {:ok, payload}, socket}
    # {:noreply, socket}
  end

  # This is invoked every time a notification is being broadcast
  # to the client. The default implementation is just to push it
  # downstream but one could filter or change the event.
  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end
end
