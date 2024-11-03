defmodule WorkbenchWeb.ToolLive.Index do
  use WorkbenchWeb, :live_view

  alias Workbench.Items
  alias Workbench.Items.Tool
  alias Workbench.Garage

  @impl true
  def mount(_params, _session, socket) do
    user_id = socket.assigns.current_user.id
    containers = Garage.list_containers(socket.assigns.current_user.id)
    socket = assign(socket, :containers, containers)
    {:ok, stream(socket, :tools, Items.list_tools(user_id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Tool")
    |> assign(:tool, Items.get_tool!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Tool")
    |> assign(:tool, %Tool{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tools")
    |> assign(:tool, nil)
  end

  @impl true
  def handle_info({WorkbenchWeb.ToolLive.FormComponent, {:saved, tool}}, socket) do
    {:noreply, stream_insert(socket, :tools, tool)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    tool = Items.get_tool!(id)
    {:ok, _} = Items.delete_tool(tool)

    {:noreply, stream_delete(socket, :tools, tool)}
  end
end
