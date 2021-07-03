defmodule LiveRushing.Players do
  alias LiveRushing.Repo
  alias LiveRushing.Players.Player
  import Ecto.Query

  def list(params) do
    IO.inspect params
    query = from(p in Player)

    Enum.reduce(params, query, fn
      {:player, player}, query ->
        player = "%" <> player <> "%"
        from q in query, where: ilike(q.name, ^player)

      {:sort, %{sort_by: sort_by, sort_order: sort_order}}, query ->
        from q in query, order_by: [{^sort_order, ^sort_by}]
    end)
    |> Repo.all()
  end
end
