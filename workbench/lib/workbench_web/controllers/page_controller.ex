defmodule WorkbenchWeb.PageController do
  use WorkbenchWeb, :controller

  alias Workbench.Items

  def home(conn, _params) do
    conn
    |> Plug.Conn.assign(:tools, Items.list_tools(conn.assigns.current_user.id))
    |> Plug.Conn.assign(:supplies, Items.list_supplies(conn.assigns.current_user.id))
    |> render(:home, layout: false)
  end
end
