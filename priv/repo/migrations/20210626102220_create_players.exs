defmodule LiveRushing.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :team, :string
      add :position, :string
      add :attempts, :integer
      add :attempts_avg, :float
      add :total_yards, :integer
      add :avg_yards_per_attempts, :float
      add :yards_per_game, :float
      add :total_touchdowns, :integer
      add :longest_rush, :integer
      add :longest_rush_with_touchdown, :boolean, default: false, null: false
      add :first_down, :integer
      add :first_down_ratio, :float
      add :fumbles, :integer
      add :twenty_yards, :integer
      add :forty_yards, :integer

      timestamps()
    end

  end
end
