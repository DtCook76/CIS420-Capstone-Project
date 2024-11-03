defmodule WorkbenchWeb.ToolLive.FormComponent do
  use WorkbenchWeb, :live_component

  alias Workbench.Items

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage tool records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="tool-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:container_id]} type="select" label="Container" options={Enum.map(@containers, fn container -> {container.name, container.id} end)} prompt="Choose a Container" />
        <.input field={@form[:image_url]} type="text" label="Image url" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Tool</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{tool: tool} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Items.change_tool(tool))
     end)}
  end

  @impl true
  def handle_event("validate", %{"tool" => tool_params}, socket) do
    changeset = Items.change_tool(socket.assigns.tool, tool_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"tool" => tool_params}, socket) do
    save_tool(socket, socket.assigns.action, tool_params)
  end

  defp save_tool(socket, :edit, tool_params) do
    case Items.update_tool(socket.assigns.tool, tool_params) do
      {:ok, tool} ->
        notify_parent({:saved, tool})

        {:noreply,
         socket
         |> put_flash(:info, "Tool updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_tool(socket, :new, tool_params) do
    tool_params = add_user_param(socket, tool_params)
    case Items.create_tool(tool_params) do
      {:ok, tool} ->
        notify_parent({:saved, tool})

        {:noreply,
         socket
         |> put_flash(:info, "Tool created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  def add_user_param(socket, params) do
    user_id = socket.assigns.current_user.id
    Map.put(params, "user_id", user_id)
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
