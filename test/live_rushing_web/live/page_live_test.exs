defmodule LiveRushingWeb.PageLiveTest do
  use LiveRushingWeb.ConnCase

  import Phoenix.LiveViewTest
  alias LiveRushing.Fixtures

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

  test "should see players loaded",  %{conn: conn} do
    [joe, shaun, breshad] = Fixtures.charge_db()
    {:ok, view, _} = live(conn, "/")

    assert has_element?(view, player_tr(joe))
    assert has_element?(view, player_tr(shaun))
    assert has_element?(view, player_tr(breshad))
  end

  test "should see players when we sort using the link",  %{conn: conn} do
    [joe, shaun, breshad] = Fixtures.charge_db()
    {:ok, view, _} = live(conn, "/?sort_by=total_yards&sort_order=asc&player=")

    assert render(view) =~ player_in_order(breshad, shaun, joe)
  end

  test "clicking sorting by patches but with players",  %{conn: conn} do
    [joe, shaun, breshad] = Fixtures.charge_db()

    {:ok, view, _} = live(conn, "/")
    assert render(view) =~ player_in_order(breshad, joe, shaun)

    view
    |> element("#yds-sort", "Yds")
    |> render_click()

    assert render(view) =~ player_in_order(joe, shaun, breshad)

    view
    |> element("#yds-sort", "Yds")
    |> render_click()

    assert render(view) =~ player_in_order(breshad, shaun, joe)
  end

  test "should see player loaded on the first page",  %{conn: conn} do
    [_joe, _shaun, breshad] = Fixtures.charge_db()
    {:ok, view, _} = live(conn, "/?page=1&per_page=1")

    assert has_element?(view, player_tr(breshad))

    view
    |> element("#page-next", ">>")
    |> render_click()

    assert_patched(view, "/?page=2&player=&per_page=1&sort_by=name&sort_order=asc")

    view
    |> element("#page-previous", "<<")
    |> render_click()

    assert_patched(view, "/?page=1&player=&per_page=1&sort_by=name&sort_order=asc")

    view
    |> element("#page-2", "2")
    |> render_click()

    assert_patched(view, "/?page=2&player=&per_page=1&sort_by=name&sort_order=asc")

  end

  defp player_in_order(p1, p2, p3), do: ~r/#{p1.id}.*#{p2.id}.*#{p3.id}/s

  defp player_tr(player), do: "#player-#{player.id}"
end
