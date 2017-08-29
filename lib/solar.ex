defmodule Solar do

  def power(%{classification: :X, scale: scale}), do: 1000 * scale
  def power(%{classification: :M, scale: scale}), do: 10 * scale
  def power(%{classification: :C, scale: scale}), do: 1 * scale

  def no_eva(flares), do: flares |> Enum.filter(&(power(&1) > 1000))

  def deadliest(flares), do: flares |> Enum.max_by(&(power(&1)))

  def flare_list(flares) do
    for flare <- flares, do: %{power: power(flare), is_deadly: power(flare) > 1000}
  end

  def deadly_flares(flares) do
    for flare <- flares,
      power <- [power(flare)],
      is_deadly <- [power > 1000],
      is_deadly == true,
      do:  %{power: power}
  end

  def total_flare_power(flares) do
    Enum.reduce flares, 0, fn(flare, total) ->
      total + power(flare)
    end
  end
end
