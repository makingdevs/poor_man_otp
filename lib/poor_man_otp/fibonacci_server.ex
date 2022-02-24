defmodule PoorMan.FibonacciServer do
  @moduledoc """
  Make the Fibonacci Sequence a Server
  """

  @doc """
  Creates a process with the Fibonacci module inside
  """
  def start(n) do
    spawn(PoorMan.Fibonacci, :sequence, [n])
  end
end
