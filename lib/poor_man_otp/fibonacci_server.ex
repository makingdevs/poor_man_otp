defmodule PoorMan.FibonacciServer do
  @moduledoc """
  Make the Fibonacci Sequence a Server
  """

  alias PoorMan.Fibonacci

  @doc """
  Creates a process with the Fibonacci module inside
  """
  def start() do
    spawn(__MODULE__, :loop, [%{}])
  end

  def loop(state) do
    receive do
      {n, pid} ->
        result = Fibonacci.sequence(n)
        send(pid, {:ok, result})

        state
        |> Map.put(n, result)
        |> loop()

      :kill ->
        :killed

      _ ->
        loop(state)
    end
  end
end
