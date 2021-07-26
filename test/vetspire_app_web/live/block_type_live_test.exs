defmodule VetspireAppWeb.BlockTypeLiveTest do
  use VetspireAppWeb.ConnCase

  import Phoenix.LiveViewTest

  alias VetspireApp.BlockTypes

  @create_attrs %{description: "some description", name: "some name"}
  @create_another_attrs %{description: "some other description", name: "some other name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  defp fixture(:block_type) do
    {:ok, block_type} = BlockTypes.create_block_type(@create_attrs)
    block_type
  end

  defp create_block_type(_) do
    block_type = fixture(:block_type)
    %{block_type: block_type}
  end

  describe "Index" do
    setup [:create_block_type]

    test "lists all block_types", %{conn: conn, block_type: block_type} do
      {:ok, _index_live, html} = live(conn, Routes.block_type_index_path(conn, :index))

      assert html =~ "Listing Block Types"
      assert html =~ block_type.description
    end

    test "saves new block_type", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.block_type_index_path(conn, :index))

      assert index_live |> element("a", "New Block type") |> render_click() =~
               "New Block type"

      assert_patch(index_live, Routes.block_type_index_path(conn, :new))

      assert index_live
             |> form("#block_type-form", block_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#block_type-form", block_type: @create_another_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.block_type_index_path(conn, :index))

      assert html =~ "Block type created successfully"
      assert html =~ "some description"
    end

    test "updates block_type in listing", %{conn: conn, block_type: block_type} do
      {:ok, index_live, _html} = live(conn, Routes.block_type_index_path(conn, :index))

      assert index_live |> element("#block_type-#{block_type.id} a", "Edit") |> render_click() =~
               "Edit Block type"

      assert_patch(index_live, Routes.block_type_index_path(conn, :edit, block_type))

      assert index_live
             |> form("#block_type-form", block_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#block_type-form", block_type: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.block_type_index_path(conn, :index))

      assert html =~ "Block type updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes block_type in listing", %{conn: conn, block_type: block_type} do
      {:ok, index_live, _html} = live(conn, Routes.block_type_index_path(conn, :index))

      assert index_live |> element("#block_type-#{block_type.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#block_type-#{block_type.id}")
    end
  end

  describe "Show" do
    setup [:create_block_type]

    test "displays block_type", %{conn: conn, block_type: block_type} do
      {:ok, _show_live, html} = live(conn, Routes.block_type_show_path(conn, :show, block_type))

      assert html =~ "Show Block type"
      assert html =~ block_type.description
    end

    test "updates block_type within modal", %{conn: conn, block_type: block_type} do
      {:ok, show_live, _html} = live(conn, Routes.block_type_show_path(conn, :show, block_type))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Block type"

      assert_patch(show_live, Routes.block_type_show_path(conn, :edit, block_type))

      assert show_live
             |> form("#block_type-form", block_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#block_type-form", block_type: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.block_type_show_path(conn, :show, block_type))

      assert html =~ "Block type updated successfully"
      assert html =~ "some updated description"
    end
  end
end
