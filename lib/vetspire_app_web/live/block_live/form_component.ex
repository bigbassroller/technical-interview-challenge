defmodule VetspireAppWeb.BlockLive.FormComponent do
  use VetspireAppWeb, :live_component

  alias VetspireApp.BlockTypes
  alias VetspireApp.BlockTypes.Block

  @impl true
  def mount(socket) do
    {:ok,
     socket
     |> assign(:uploaded_files, [])
     |> allow_upload(:image, accept: ~w(.jpg .jpeg), max_entries: 2)}
  end

  @impl true
  def update(%{block: block} = assigns, socket) do
    changeset = BlockTypes.change_block(block)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"block" => block_params}, %{assigns: %{uploads: %{image: %{entries: []}}}} = socket) do

    changeset =
      socket.assigns.block
      |> BlockTypes.change_block(block_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"block" => block_params}, %{assigns: %{uploads: _}} = socket) do
    image = put_image_url(socket, %Block{})

    changeset =
      socket.assigns.block
      |> BlockTypes.change_block(%{block_params | "image" => image})
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"block" => block_params}, socket) do
    save_block(socket, socket.assigns.action, block_params)
  end

  defp save_block(socket, :edit, block_params) do
    case BlockTypes.update_block(socket.assigns.block, block_params, &consume_image(socket, &1)) do
      {:ok, _block} ->
        {:noreply,
         socket
         |> put_flash(:info, "Block updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_block(socket, :new, block_params) do
    case BlockTypes.create_block(block_params, &consume_image(socket, &1)) do
      {:ok, _block} ->
        {:noreply,
         socket
         |> put_flash(:info, "Block created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def consume_image(socket, %Block{} = block) do
    consume_uploaded_entries(socket, :image, fn meta, entry ->
      dest = Path.join("priv/static/uploads", "#{entry.uuid}.#{ext(entry)}")
      File.cp!(meta.path, dest)
    end)
    {:ok, block}
  end

  def ext(upload_entry) do
    [ext | _] = MIME.extensions(upload_entry.client_type)
    ext
  end

  defp put_image_url(socket, %Block{} = _block) do
    upload_entry = socket.assigns.uploads.image.entries |> hd
    Routes.static_path(socket, "/uploads/#{upload_entry.uuid}.#{ext(upload_entry)}")
  end
end
