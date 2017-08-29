defmodule SolarTest do
  use ExUnit.Case
  import Timex
  import Solar

  setup do
    flares = [
      %{classification: :X, stations: 10, scale: 99, date: Timex.iso_triplet({1859, 8, 29})},
      %{classification: :M, stations: 10, scale: 5.8, date: Timex.iso_triplet({2015, 1, 12})},
      %{classification: :M, stations: 6, scale: 1.2, date: Timex.iso_triplet({2015, 2, 9})},
      %{classification: :C, stations: 6, scale: 3.2, date: Timex.iso_triplet({2015, 4, 18})},
      %{classification: :M, stations: 7, scale: 83.6, date: Timex.iso_triplet({2015, 6, 23})},
      %{classification: :C, stations: 10, scale: 2.5, date: Timex.iso_triplet({2015, 7, 4})},
      %{classification: :X, stations: 2, scale: 72, date: Timex.iso_triplet({2012, 7, 23})},
      %{classification: :X, stations: 4, scale: 45, date: Timex.iso_triplet({2003, 11, 4})},
    ]
    {:ok, data: flares}
  end

  test "We have 8 solar flares", %{data: flares} do
    assert length(flares) == 8
  end

  test "Power", %{data: flares} do
    [flare|_] = flares
    assert power(flare) == 1000 * 99
  end

  test "no EVA", %{data: flares} do
    assert no_eva(flares) |> length > 0
  end

  test "deadliest", %{data: flares} do
    bad_one = %{classification: :X, stations: 10, scale: 99, date: Timex.iso_triplet({1859, 8, 29})}
    assert deadliest(flares) == bad_one
  end

  test "total flare power", %{data: flares} do
    Solar.total_flare_power(flares) |> IO.inspect
  end

  test "flare list", %{data: flares} do
    Solar.flare_list(flares) |> IO.inspect
  end

  test "deadly flares", %{data: flares} do
    Solar.deadly_flares(flares) |> IO.inspect
  end
end
