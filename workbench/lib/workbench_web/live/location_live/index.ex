defmodule WorkbenchWeb.LocationLive.Index do
  use WorkbenchWeb, :live_view

  alias Workbench.Garage
  alias Workbench.Garage.Location

  @impl true
  def mount(_params, _session, socket) do
    user_id = socket.assigns.current_user.id
    IO.inspect(socket)
    {:ok, stream(socket, :locations, Garage.list_locations(user_id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Location")
    |> assign(:location, Garage.get_location!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Location")
    |> assign(:location, %Location{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Locations")
    |> assign(:location, nil)
  end

  @impl true
  def handle_info({WorkbenchWeb.LocationLive.FormComponent, {:saved, location}}, socket) do
    {:noreply, stream_insert(socket, :locations, location)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    location = Garage.get_location!(id)
    {:ok, _} = Garage.delete_location(location)

    {:noreply, stream_delete(socket, :locations, location)}
  end
end
