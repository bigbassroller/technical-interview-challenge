defmodule VetspireAppWeb.BlockTypeLive.Index do
  use VetspireAppWeb, :live_view

  alias VetspireApp.BlockTypes
  alias VetspireApp.BlockTypes.BlockType

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :block_types, list_block_types())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Block type")
    |> assign(:block_type, BlockTypes.get_block_type!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Block type")
    |> assign(:block_type, %BlockType{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Block Types")
    |> assign(:block_type, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    block_type = BlockTypes.get_block_type!(id)
    {:ok, _} = BlockTypes.delete_block_type(block_type)

    {:noreply, assign(socket, :block_types, list_block_types())}
  end

  defp list_block_types do
    BlockTypes.list_block_types()
  end
end
