defmodule VetspireApp.BlockTypes do
  @moduledoc """
  The BlockTypes context.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias VetspireApp.Repo

  alias VetspireApp.BlockTypes.BlockType

  @doc """
  Returns the list of block_types.

  ## Examples

      iex> list_block_types()
      [%BlockType{}, ...]

  """
  def list_block_types do
    Repo.all(BlockType)
  end

  @doc """
  Gets a single block_type.

  Raises `Ecto.NoResultsError` if the Block type does not exist.

  ## Examples

      iex> get_block_type!(123)
      %BlockType{}

      iex> get_block_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_block_type!(id), do: Repo.get!(BlockType, id)

  @doc """
  Creates a block_type.

  ## Examples

      iex> create_block_type(%{field: value})
      {:ok, %BlockType{}}

      iex> create_block_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_block_type(attrs \\ %{}) do
    %BlockType{}
    |> BlockType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a block_type.

  ## Examples

      iex> update_block_type(block_type, %{field: new_value})
      {:ok, %BlockType{}}

      iex> update_block_type(block_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_block_type(%BlockType{} = block_type, attrs) do
    block_type
    |> BlockType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a block_type.

  ## Examples

      iex> delete_block_type(block_type)
      {:ok, %BlockType{}}

      iex> delete_block_type(block_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_block_type(%BlockType{} = block_type) do
    Repo.delete(block_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking block_type changes.

  ## Examples

      iex> change_block_type(block_type)
      %Ecto.Changeset{data: %BlockType{}}

  """
  def change_block_type(%BlockType{} = block_type, attrs \\ %{}) do
    BlockType.changeset(block_type, attrs)
  end

  alias VetspireApp.BlockTypes.Block

  @doc """
  Returns the list of blocks.

  ## Examples

      iex> list_blocks()
      [%Block{}, ...]

  """
  def list_blocks do
    Block
    |> Repo.all()
    |> Repo.preload([:block_type])
  end

  @doc """
  Gets a single block.

  Raises `Ecto.NoResultsError` if the Block does not exist.

  ## Examples

      iex> get_block!(123)
      %Block{}

      iex> get_block!(456)
      ** (Ecto.NoResultsError)

  """
  def get_block!(id) do
    Block
    |> Repo.get!(id)
    |> Repo.preload([:block_type])
  end

  @doc """
  Creates a block.

  ## Examples

      iex> create_block(%{field: value})
      {:ok, %Block{}}

      iex> create_block(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_block(attrs \\ %{}, after_save \\ &{:ok, &1}) do
    block_type_name = attrs
    |> Map.get("block_type")
    |> Map.get("name")

    block_type = Repo.get_by(BlockType, name: block_type_name)

    if block_type do
      %Block{}
      |> Block.changeset(attrs)
      |> put_assoc(:block_type, block_type)
      |> Repo.insert()
      |> after_save(after_save) 
    else
      %Block{}
      |> Block.changeset(attrs)
      |> cast_assoc(:block_type, with: &BlockType.changeset/2)
      |> Repo.insert()
      |> after_save(after_save)
    end
  end

  @doc """
  Updates a block.

  ## Examples

      iex> update_block(block, %{field: new_value})
      {:ok, %Block{}}

      iex> update_block(block, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_block(%Block{} = block, attrs, after_save \\ &{:ok, &1}) do
    block_type_name = attrs
    |> Map.get("block_type")
    |> Map.get("name")
    |> IO.inspect(label: '🐬')

    block_type = Repo.get_by(BlockType, name: block_type_name)

    if block_type do
      block
      |> Block.changeset(attrs)
      |> put_assoc(:block_type, block_type)
      |> Repo.update()
      |> after_save(after_save) 
    else
      
      block
      |> Block.changeset(attrs)
      |> cast_assoc(:block_type, with: &BlockType.changeset/2)
      |> Repo.update()
      |> after_save(after_save)
    end

  end

  defp after_save({:ok, block}, func) do
    {:ok, _block} = func.(block)
  end

  @doc """
  Deletes a block.

  ## Examples

      iex> delete_block(block)
      {:ok, %Block{}}

      iex> delete_block(block)
      {:error, %Ecto.Changeset{}}

  """
  def delete_block(%Block{} = block) do
    Repo.delete(block)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking block changes.

  ## Examples

      iex> change_block(block)
      %Ecto.Changeset{data: %Block{}}

  """
  def change_block(%Block{} = block, attrs \\ %{}) do
    Block.changeset(block, attrs)
  end
end
