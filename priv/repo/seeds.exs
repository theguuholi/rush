defmodule CreatePlayers do
  def run() do
    "rushing.json"
    |> read_file_and_decode()
    |> Enum.map(&create_struct/1)
  end

  def read_file_and_decode(file) do
    file
    |> File.read!()
    |> Jason.decode!()
  end

  def create_struct(player) do
    %LiveRushing.Player{
      name: player["Player"],
      team: player["Team"],
      position: player["Pos"],
      attempts: player["Att"],
      attempts_avg: player["Att/G"] / 1,
      total_yards: build_total_yards_field(player["Yds"]),
      avg_yards_per_attempts: player["Avg"] / 1,
      yards_per_game: player["Yds/G"] / 1,
      total_touchdowns: player["TD"],
      longest_rush: build_longest_rush(player["Lng"]),
      longest_rush_with_touchdown: build_longest_rush_with_touch_down(player["Lng"]),
      first_down: player["1st"],
      first_down_ratio: player["1st%"] / 1,
      fumbles: player["FUM"],
      twenty_yards: player["20+"],
      forty_yards: player["40+"]
    }
    |> LiveRushing.Repo.insert!
  end

  def build_total_yards_field(total_yards) do
    (total_yards |> is_integer() && total_yards) ||
    total_yards
    |> String.replace(",", "")
    |> String.to_integer()
  end

  def build_longest_rush(lgn) do
    (lgn |> is_integer() && lgn) ||
    lgn
    |> String.replace("T", "")
    |> String.to_integer()
  end

  def build_longest_rush_with_touch_down(lgn) do
    if is_integer(lgn) do
      false
    else
      String.contains?(lgn, "T")
    end
  end
end

CreatePlayers.run()
#mix ecto.reset
