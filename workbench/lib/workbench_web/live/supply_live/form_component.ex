defmodule WorkbenchWeb.SupplyLive.FormComponent do
  use WorkbenchWeb, :live_component

  alias Workbench.Items

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage supply records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="supply-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:restock_link]} type="text" label="Restock link" />
        <.input field={@form[:image_url]} type="text" label="Image url" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Supply</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{supply: supply} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Items.change_supply(supply))
     end)}
  end

  @impl true
  def handle_event("validate", %{"supply" => supply_params}, socket) do
    changeset = Items.change_supply(socket.assigns.supply, supply_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"supply" => supply_params}, socket) do
    save_supply(socket, socket.assigns.action, supply_params)
  end

  defp save_supply(socket, :edit, supply_params) do
    case Items.update_supply(socket.assigns.supply, supply_params) do
      {:ok, supply} ->
        notify_parent({:saved, supply})

        {:noreply,
         socket
         |> put_flash(:info, "Supply updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_supply(socket, :new, supply_params) do
    case Items.create_supply(supply_params) do
      {:ok, supply} ->
        notify_parent({:saved, supply})

        {:noreply,
         socket
         |> put_flash(:info, "Supply created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
