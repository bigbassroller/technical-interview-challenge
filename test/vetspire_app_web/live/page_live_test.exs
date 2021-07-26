defmodule VetspireAppWeb.PageLiveTest do
  use VetspireAppWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Welcome to BlockTypes!"
    assert render(page_live) =~ "Welcome to BlockTypes!"
  end
end
