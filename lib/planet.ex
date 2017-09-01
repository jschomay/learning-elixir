defmodule Planet do

  import Calcs
  import Converter
  import Physics.Laws

  defstruct [name: nil, type: :rocky, mass: 0, radius: 0, ev: 0]

  defp planets do
    [
      {:mercury, %Planet{name: "Mercury", type: :rocky, mass: 3.3e23, radius: 2.439e6 }},
      {:venus, %Planet{name: "Venus", type: :rocky, mass: 4.86e24, radius: 6.05e6 }},
      {:earth, %Planet{name: "Earth", type: :rocky, mass: 5.972e24, radius: 6.37e6 }},
      {:mars, %Planet{name: "Mars", type: :rocky, mass: 6.41e23, radius: 3.37e6 }},
      {:jupiter, %Planet{name: "Jupiter", type: :gaseous, mass: 1.89e27, radius: 7.14e7 }},
      {:saturn, %Planet{name: "Saturn", type: :gaseous, mass: 5.68e26, radius: 6.02e7 }},
      {:uranus, %Planet{name: "Uranus", type: :gaseous, mass: 8.68e25, radius: 2.55e7 }},
      {:neptune, %Planet{name: "Neptune", type: :gaseous, mass: 1.02e26, radius: 2.47e7 }},
    ]
  end


  def select do
    for {key, planet} <- planets,
      ev <- [escape_velocity(planet)],
      do: {key, %{planet | ev: ev}}
  end

  def escape_velocity, do: escape_velocity(select[:earth])

  def escape_velocity(planet) when is_map(planet) do
    planet
      |> calculate_escape
      |> to_km
      |> to_nearest_tenth
  end

  def escape_velocity(:earth), do: escape_velocity(select[:earth])
  def escape_velocity(:moon), do: escape_velocity(select[:moon])

  defp calculate_escape(%{mass: mass, radius: radius}) do
    2 * newtons_gravitational_constant * mass / radius
      |> square_root
  end
end
