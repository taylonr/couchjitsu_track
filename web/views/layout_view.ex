defmodule CouchjitsuTrack.LayoutView do
  use CouchjitsuTrack.Web, :view

  def ogtags(assigns) do
      if assigns[:ogtags] do
        for {key, value} <- assigns[:ogtags] do
            raw("\t<meta property=\"#{key}\" content=\"#{value}\">\n")
        end
      end
  end

  def get_user (conn) do
    user = Plug.Conn.get_session(conn, :current_user)
    if user do
      user.name
    else
      "Log In"
    end
  end

  def active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])
    if path == current_path do
      "active red"
    else
      nil
    end
  end
end
