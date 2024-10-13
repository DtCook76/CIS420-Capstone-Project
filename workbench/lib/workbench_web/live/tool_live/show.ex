defmodule WorkbenchWeb.ToolLive.Show do
  use WorkbenchWeb, :live_view

  alias Workbench.Items

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:tool, Items.get_tool!(id))}
  end

  defp page_title(:show), do: "Show Tool"
  defp page_title(:edit), do: "Edit Tool"
end
