defmodule LiveRushing.Players do
  alias LiveRushing.Repo
  alias LiveRushing.Players.Player
  import Ecto.Query

  def list(params) do
    query = from(p in Player)

    Enum.reduce(params, query, fn
      {:player, player}, query ->
        player = "%" <> player <> "%"
        from q in query, where: ilike(q.name, ^player)

      {:paginate, %{page: page, per_page: per_page}}, query ->
        from q in query, offset: ^((page - 1) * per_page), limit: ^per_page

      {:sort, %{sort_by: sort_by, sort_order: sort_order}}, query ->
        from q in query, order_by: [{^sort_order, ^sort_by}]
    end)
    |> Repo.all()
  end
end
