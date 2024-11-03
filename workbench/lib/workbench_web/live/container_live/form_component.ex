defmodule WorkbenchWeb.ContainerLive.FormComponent do
  use WorkbenchWeb, :live_component

  alias Workbench.Garage

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage container records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="container-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:type]} type="text" label="Type" />
        <.input field={@form[:location_id]} type="select" label="Location" options={Enum.map(@locations, fn location -> {location.name, location.id} end)} prompt="Choose a Location" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Container</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{container: container} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Garage.change_container(container))
     end)}
  end

  @impl true
  def handle_event("validate", %{"container" => container_params}, socket) do
    changeset = Garage.change_container(socket.assigns.container, container_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"container" => container_params}, socket) do
    save_container(socket, socket.assigns.action, container_params)
  end

  defp save_container(socket, :edit, container_params) do
    case Garage.update_container(socket.assigns.container, container_params) do
      {:ok, container} ->
        notify_parent({:saved, container})

        {:noreply,
         socket
         |> put_flash(:info, "Container updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_container(socket, :new, container_params) do
    container_params = add_user_param(socket, container_params)
    case Garage.create_container(container_params) do
      {:ok, container} ->
        notify_parent({:saved, container})

        {:noreply,
         socket
         |> put_flash(:info, "Container created successfully")
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
