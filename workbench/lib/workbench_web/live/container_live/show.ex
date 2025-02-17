defmodule WorkbenchWeb.ContainerLive.Show do
  use WorkbenchWeb, :live_view

  alias Workbench.Garage

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:container, Garage.get_container!(id))}
  end

  defp page_title(:show), do: "Show Container"
  defp page_title(:edit), do: "Edit Container"
end
