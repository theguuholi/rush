defmodule LiveRushing.Players.Player do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "players" do
    field :attempts, :integer
    field :attempts_avg, :float
    field :avg_yards_per_attempts, :float
    field :first_down, :integer
    field :first_down_ratio, :float
    field :forty_yards, :integer
    field :fumbles, :integer
    field :longest_rush, :integer
    field :longest_rush_with_touchdown, :boolean, default: false
    field :name, :string
    field :position, :string
    field :team, :string
    field :total_touchdowns, :integer
    field :total_yards, :integer
    field :twenty_yards, :integer
    field :yards_per_game, :float

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :team, :position, :attempts, :attempts_avg, :total_yards, :avg_yards_per_attempts, :yards_per_game, :total_touchdowns, :longest_rush, :longest_rush_with_touchdown, :first_down, :first_down_ratio, :fumbles, :twenty_yards, :forty_yards])
    |> validate_required([:name, :team, :position, :attempts, :attempts_avg, :total_yards, :avg_yards_per_attempts, :yards_per_game, :total_touchdowns, :longest_rush, :longest_rush_with_touchdown, :first_down, :first_down_ratio, :fumbles, :twenty_yards, :forty_yards])
  end
end
