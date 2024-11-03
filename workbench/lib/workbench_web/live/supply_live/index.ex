defmodule WorkbenchWeb.SupplyLive.Index do
  use WorkbenchWeb, :live_view

  alias Workbench.Items
  alias Workbench.Items.Supply
  alias Workbench.Garage

  @impl true
  def mount(_params, _session, socket) do
    user_id = socket.assigns.current_user.id
    containers = Garage.list_containers(socket.assigns.current_user.id)
    socket = assign(socket, :containers, containers)
    {:ok, stream(socket, :supplies, Items.list_supplies(user_id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Supply")
    |> assign(:supply, Items.get_supply!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Supply")
    |> assign(:supply, %Supply{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Supplies")
    |> assign(:supply, nil)
  end

  @impl true
  def handle_info({WorkbenchWeb.SupplyLive.FormComponent, {:saved, supply}}, socket) do
    {:noreply, stream_insert(socket, :supplies, supply)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    supply = Items.get_supply!(id)
    {:ok, _} = Items.delete_supply(supply)

    {:noreply, stream_delete(socket, :supplies, supply)}
  end
end
