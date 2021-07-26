defmodule VetspireAppWeb.BlockTypeLive.FormComponent do
  use VetspireAppWeb, :live_component

  alias VetspireApp.BlockTypes

  @impl true
  def update(%{block_type: block_type} = assigns, socket) do
    changeset = BlockTypes.change_block_type(block_type)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"block_type" => block_type_params}, socket) do
    changeset =
      socket.assigns.block_type
      |> BlockTypes.change_block_type(block_type_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"block_type" => block_type_params}, socket) do
    save_block_type(socket, socket.assigns.action, block_type_params)
  end

  defp save_block_type(socket, :edit, block_type_params) do
    case BlockTypes.update_block_type(socket.assigns.block_type, block_type_params) do
      {:ok, _block_type} ->
        {:noreply,
         socket
         |> put_flash(:info, "Block type updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_block_type(socket, :new, block_type_params) do
    case BlockTypes.create_block_type(block_type_params) do
      {:ok, _block_type} ->
        {:noreply,
         socket
         |> put_flash(:info, "Block type created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
