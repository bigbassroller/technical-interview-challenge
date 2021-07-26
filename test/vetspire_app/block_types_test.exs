defmodule VetspireApp.BlockTypesTest do
  use VetspireApp.DataCase

  alias VetspireApp.BlockTypes

  describe "block_types" do
    alias VetspireApp.BlockTypes.BlockType

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def block_type_fixture(attrs \\ %{}) do
      {:ok, block_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> BlockTypes.create_block_type()

      block_type
    end

    test "list_block_types/0 returns all block_types" do
      block_type = block_type_fixture()
      assert BlockTypes.list_block_types() == [block_type]
    end

    test "get_block_type!/1 returns the block_type with given id" do
      block_type = block_type_fixture()
      assert BlockTypes.get_block_type!(block_type.id) == block_type
    end

    test "create_block_type/1 with valid data creates a block_type" do
      assert {:ok, %BlockType{} = block_type} = BlockTypes.create_block_type(@valid_attrs)
      assert block_type.description == "some description"
      assert block_type.name == "some name"
    end

    test "create_block_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BlockTypes.create_block_type(@invalid_attrs)
    end

    test "update_block_type/2 with valid data updates the block_type" do
      block_type = block_type_fixture()
      assert {:ok, %BlockType{} = block_type} = BlockTypes.update_block_type(block_type, @update_attrs)
      assert block_type.description == "some updated description"
      assert block_type.name == "some updated name"
    end

    test "update_block_type/2 with invalid data returns error changeset" do
      block_type = block_type_fixture()
      assert {:error, %Ecto.Changeset{}} = BlockTypes.update_block_type(block_type, @invalid_attrs)
      assert block_type == BlockTypes.get_block_type!(block_type.id)
    end

    test "delete_block_type/1 deletes the block_type" do
      block_type = block_type_fixture()
      assert {:ok, %BlockType{}} = BlockTypes.delete_block_type(block_type)
      assert_raise Ecto.NoResultsError, fn -> BlockTypes.get_block_type!(block_type.id) end
    end

    test "change_block_type/1 returns a block_type changeset" do
      block_type = block_type_fixture()
      assert %Ecto.Changeset{} = BlockTypes.change_block_type(block_type)
    end
  end

  describe "blocks" do
    alias VetspireApp.BlockTypes.Block

    # @valid_attrs %{description: "some description", image: "some image", name: "some name"}
    # @update_attrs %{description: "some updated description", image: "some updated image", name: "some updated name"}
    # @invalid_attrs %{description: nil, image: nil, name: nil}

    @valid_attrs %{
      "block_type" => %{"name" => "option1"},
      "description" => "some description",
      "image" => "some image",
      "name" => "some name"
    }
    @update_attrs %{
      "block_type" => %{"name" => "option2"},
      "description" => "some updated description",
      "image" => "some updated image",
      "name" => "some updated name"
    }
    @invalid_attrs %{
      "block_type" => %{"name" => "option2"},
      "description" => nil,
      "image" => nil,
      "name" => nil
    }

    def block_fixture(attrs \\ %{}) do
      {:ok, block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> BlockTypes.create_block()

      block
    end

    test "list_blocks/0 returns all blocks" do
      block = block_fixture()
      assert BlockTypes.list_blocks() == [block]
    end

    test "get_block!/1 returns the block with given id" do
      block = block_fixture()
      assert BlockTypes.get_block!(block.id) == block
    end

    test "create_block/1 with valid data creates a block" do
      assert {:ok, %Block{} = block} = BlockTypes.create_block(@valid_attrs)
      assert block.description == "some description"
      assert block.image == "some image"
      assert block.name == "some name"
    end

    test "create_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BlockTypes.create_block(@invalid_attrs)
    end

    test "update_block/2 with valid data updates the block" do
      block = block_fixture()
      assert {:ok, %Block{} = block} = BlockTypes.update_block(block, @update_attrs)
      assert block.description == "some updated description"
      assert block.image == "some updated image"
      assert block.name == "some updated name"
    end

    test "update_block/2 with invalid data returns error changeset" do
      block = block_fixture()
      assert {:error, %Ecto.Changeset{}} = BlockTypes.update_block(block, @invalid_attrs)
      assert block == BlockTypes.get_block!(block.id)
    end

    test "delete_block/1 deletes the block" do
      block = block_fixture()
      assert {:ok, %Block{}} = BlockTypes.delete_block(block)
      assert_raise Ecto.NoResultsError, fn -> BlockTypes.get_block!(block.id) end
    end

    test "change_block/1 returns a block changeset" do
      block = block_fixture()
      assert %Ecto.Changeset{} = BlockTypes.change_block(block)
    end
  end
end
