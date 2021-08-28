defmodule LiveRushingWeb.PageLiveTest do
  use LiveRushingWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Player"
    assert render(page_live) =~ "Player"
  end

  test "clicking sorting by patches",  %{conn: conn} do
    {:ok, view, _} = live(conn, "/")

    view
    |> element("#yds-sort", "Yds")
    |> render_click()

    assert_patched(view, "/?sort_by=total_yards&sort_order=desc&player=")

    view
    |> element("#yds-sort", "Yds")
    |> render_click()

    assert_patched(view, "/?sort_by=total_yards&sort_order=asc&player=")
  end
end
