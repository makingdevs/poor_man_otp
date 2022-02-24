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
      {:values, pid} ->
        send(pid, {:ok, state})
        loop(state)

      {n, pid} ->
        result =
          case Map.get(state, n) do
            nil -> Fibonacci.sequence(n)
            result -> result
          end

        send(pid, {:ok, result})

        state
        |> Map.put_new(n, result)
        |> loop()

      :kill ->
        :killed

      _ ->
        loop(state)
    end
  end
end
