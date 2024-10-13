defmodule WorkbenchWeb.SupplyLive.Show do
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
     |> assign(:supply, Items.get_supply!(id))}
  end

  defp page_title(:show), do: "Show Supply"
  defp page_title(:edit), do: "Edit Supply"
end
