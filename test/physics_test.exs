defmodule PhysicsTest do
  use ExUnit.Case

  test "escape velocity of earth is correct" do
    ev = Physics.Rocketry.escape_velocity(:earth)
    assert ev == 11.2 #what should this value be?
  end

  test "escape velocity of mars is correct" do
    ev = Physics.Rocketry.escape_velocity(:mars)
    assert ev == 5.0 #what should this value be?
  end

  test "escape velocity of moon is correct" do
    ev = Physics.Rocketry.escape_velocity(:moon)
    assert ev == 2.4 #what should this value be?
  end

  test "escape velocity of planet X is correct" do
    ev =  %{mass: 4.0e22, radius: 6.21e6} |> Physics.Rocketry.escape_velocity
    assert ev == 0.9
    #use assert here
  end

  test "Converting to to_light_seconds" do
    ls = Converter.to_light_seconds({:miles, 1000}, precision: 5)
    assert ls == 0.00537
  end

  test "Converter one works" do
    ls = Converter.to_light_seconds({:miles, 1000}, precision: 5)
    assert ls == 0.00537
  end

  test "seconds_to_hours" do
    assert 3600 |> Converter.seconds_to_hours == 1
  end

  test "Orbital acceleration for earth at 100km" do
    orbital_acc = Physics.Rocketry.orbital_acceleration(100)
    assert orbital_acc == 9.512678810620692
  end

  test "Orbital term for 100km above earth" do
    term = Physics.Rocketry.orbital_term(8000)
    assert (term > 4) && (term < 5)
  end

  test "Oribital height at T = 4h" do
    height = Physics.Rocketry.orbital_height(4)
    assert height |> Converter.to_nearest_tenth == 54450.5
  end

end
