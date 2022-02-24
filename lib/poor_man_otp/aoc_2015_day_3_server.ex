defmodule PoorMan.AOC2015.Day3Server do
  @moduledoc """
  Make the AOC2015.Day3 a Server
  """

  alias PoorMan.AOC2015.Day3

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

      {instructions, pid} ->
        result =
          case Map.get(state, instructions) do
            nil -> Day3.deliver(instructions)
            result -> result
          end

        send(pid, {:ok, result})

        state
        |> Map.put_new(instructions, result)
        |> loop()

      :kill ->
        :killed

      _ ->
        loop(state)
    end
  end
end
