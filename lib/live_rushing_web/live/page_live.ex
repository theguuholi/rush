defmodule LiveRushingWeb.PageLive do
  use LiveRushingWeb, :live_view
  alias LiveRushing.Players
  alias Phoenix.View

  @impl true
  def mount(_params, _session, socket) do
    sort = %{sort_by: "name", sort_order: :asc}
    params = [sort: sort, player: ""]
    {:ok, assign(socket, params), temporary_assigns: [player: []]}
  end

  @impl true
  def handle_params(params, _, socket) do
    params = get_params(params)
    socket =
      socket
      |> assign(params)
      |> assign(players: Players.list(params))

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    View.render(LiveRushingWeb.PageView, "index.html", assigns)
  end

  def get_params(params) do
    sort_by = (params["sort_by"] || "name") |> String.to_atom()
    sort_order = (params["sort_order"] || "asc") |> String.to_atom()
    player = params["player"] || ""
    [player: player, sort: %{sort_by: sort_by, sort_order: sort_order}]
  end

  def sort_link(socket, text, field, sort, player) do
    live_patch(text,
      to:
        Routes.page_path(socket, :index,
          sort_by: field,
          sort_order: sort.sort_order,
          player: player
        )
    )
  end
end
