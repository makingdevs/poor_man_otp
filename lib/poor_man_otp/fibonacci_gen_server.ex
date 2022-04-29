defmodule PoorMan.FibonacciGenServer do
  use GenServer

  alias PoorMan.Fibonacci

  def start_link(default \\ []) do
    GenServer.start_link(__MODULE__, default)
  end

  def init(_) do
    {:ok, []}
  end

  def handle_call({:compute, n}, _from, state) do
    result = Fibonacci.sequence(n)
    {:reply, result, state}
  end
end
