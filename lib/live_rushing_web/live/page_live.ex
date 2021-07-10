defmodule LiveRushingWeb.PageLive do
  use LiveRushingWeb, :live_view
  alias LiveRushing.Players
  alias Phoenix.View

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [players: []]}
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
    page = String.to_integer(params["page"] ||  "1")
    per_page = String.to_integer(params["per_page"] ||  "5")
    paginate = %{page: page, per_page: per_page}

    sort_by = (params["sort_by"] || "name") |> String.to_atom()
    sort_order = (params["sort_order"] || "asc") |> String.to_atom()
    sort = %{sort_by: sort_by, sort_order: sort_order}

    player = params["player"] || ""

    [player: player, sort: sort, paginate: paginate]
  end

  def sort_link(socket, text, field, sort, player) do
    live_patch(text,
      to:
        Routes.page_path(socket, :index,
          sort_by: field,
          sort_order: (sort.sort_order == :asc && :desc) || :asc,
          player: player
        )
    )
  end

  def pagination_link(socket, text, page, player, sort, paginate) do
    live_patch(text,
      to:
        Routes.page_path(
          socket,
          :index,
          page: page,
          player: player,
          per_page: paginate.per_page,
          sort_by: sort.sort_by,
          sort_order: sort.sort_order
        )
    )
  end

  @impl true
  def handle_event("search", %{"player" => player}, socket) do
    {:noreply, push_patch(
      socket,
      to:
      Routes.page_path(
        socket,
        :index,
        page: socket.assigns.paginate.page,
        player: player,
        per_page: socket.assigns.paginate.per_page,
        sort_by: socket.assigns.sort.sort_by,
        sort_order: socket.assigns.sort.sort_order,
      )
    )}
  end
end
