defmodule WorkbenchWeb.ContainerLive.Index do
  use WorkbenchWeb, :live_view

  alias Workbench.Garage
  alias Workbench.Garage.Container

  @impl true
  def mount(_params, _session, socket) do
    user_id = socket.assigns.current_user.id
    locations = Garage.list_locations(socket.assigns.current_user.id)
    socket = assign(socket, :locations, locations)
    IO.inspect(socket)
    {:ok, stream(socket, :containers, Garage.list_containers(user_id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Container")
    |> assign(:container, Garage.get_container!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Container")
    |> assign(:container, %Container{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Containers")
    |> assign(:container, nil)
  end

  @impl true
  def handle_info({WorkbenchWeb.ContainerLive.FormComponent, {:saved, container}}, socket) do
    {:noreply, stream_insert(socket, :containers, container)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    container = Garage.get_container!(id)
    {:ok, _} = Garage.delete_container(container)

    {:noreply, stream_delete(socket, :containers, container)}
  end
end
