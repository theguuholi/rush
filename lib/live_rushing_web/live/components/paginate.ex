defmodule LiveRushingWeb.Components.Paginate do
  use LiveRushingWeb, :live_component
  alias Phoenix.View

  @impl true
  def render(assigns) do
    View.render(LiveRushingWeb.PageView, "paginate.html", assigns)
  end
end
