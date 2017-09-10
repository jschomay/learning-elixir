defmodule Choir do

  @voices ["Bells", "Good News" , "Pipe Organ", "Cellos", "Bad News"]

  def conductor do
    sing
    Process.sleep 3000
    sing
  end

  def sing do
    sing_(5)
  end

  defp sing_(0), do: IO.puts "all done"
  defp sing_(n) do
    {:ok, pid} = Singer.start_link
    voice = Enum.random(@voices)
    Singer.sing_it pid, voice
    Process.sleep(200)
    sing_(n-1)
  end

end

defmodule Singer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def sing_it(pid, data) do
    GenServer.cast(pid, {:sing, data})
  end

  def handle_cast({:sing, voice}, _state) do
    IO.puts "Singing with #{voice}"
    System.cmd "say", ["-v", voice, "Elixir is AWESOME"]
    {:noreply, []}
  end
end
