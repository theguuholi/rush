defmodule LiveRushingWeb.Components.Sort do
  use LiveRushingWeb, :live_component
  alias Phoenix.View

  @impl true
  def render(assigns) do
    View.render(LiveRushingWeb.PageView, "sort.html", assigns)
  end
end
