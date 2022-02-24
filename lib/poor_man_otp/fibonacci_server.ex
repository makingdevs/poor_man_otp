defmodule PoorMan.FibonacciServer do
  @moduledoc """
  Make the Fibonacci Sequence a Server
  """

  alias PoorMan.Fibonacci

  @doc """
  Creates a process with the Fibonacci module inside
  """
  def start() do
    spawn(__MODULE__, :loop, [])
  end

  def loop() do
    receive do
      {n, pid} ->
        send(pid, {:ok, Fibonacci.sequence(n)})
        loop()

      _ ->
        loop()
    end
  end
end
