defmodule LiveRushing.Fixtures do
  alias LiveRushing.{Repo, Players.Player}

  def payloads,
    do: [
      %Player{
        attempts: 2,
        attempts_avg: 2.0,
        avg_yards_per_attempts: 3.5,
        first_down: 0,
        first_down_ratio: 0.0,
        forty_yards: 0,
        fumbles: 0,
        longest_rush: 7,
        longest_rush_with_touchdown: false,
        name: "Joe Banyard",
        position: "RB",
        team: "JAX",
        total_touchdowns: 0,
        total_yards: 7,
        twenty_yards: 0,
        yards_per_game: 7.0
      },
      %Player{
        attempts: 5,
        attempts_avg: 1.7,
        avg_yards_per_attempts: 1.0,
        first_down: 0,
        first_down_ratio: 0.0,
        forty_yards: 0,
        fumbles: 0,
        longest_rush: 9,
        longest_rush_with_touchdown: false,
        name: "Shaun Hill",
        position: "QB",
        team: "MIN",
        total_touchdowns: 0,
        total_yards: 5,
        twenty_yards: 0,
        yards_per_game: 1.7
      },
      %Player{
        attempts: 1,
        attempts_avg: 0.1,
        avg_yards_per_attempts: 2.0,
        first_down: 0,
        first_down_ratio: 0.0,
        forty_yards: 0,
        fumbles: 0,
        longest_rush: 2,
        longest_rush_with_touchdown: false,
        name: "Breshad Perriman",
        position: "WR",
        team: "BAL",
        total_touchdowns: 0,
        total_yards: 2,
        twenty_yards: 0,
        yards_per_game: 0.1
      }
    ]

  def charge_db, do: Enum.map(payloads(), &Repo.insert!/1)
end
