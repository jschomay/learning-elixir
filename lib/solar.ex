defmodule Solar do

  def power(%{classification: :X, scale: scale}), do: 1000 * scale
  def power(%{classification: :M, scale: scale}), do: 10 * scale
  def power(%{classification: :C, scale: scale}), do: 1 * scale

  def no_eva(flares), do: flares |> Enum.filter(&(power(&1) > 1000))

  def deadliest(flares), do: flares |> Enum.max_by(&(power(&1)))
end
