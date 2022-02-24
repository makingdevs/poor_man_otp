defmodule PoorMan.FibonacciServer do
  @moduledoc """
  Make the Fibonacci Sequence a Server
  """

  @behaviour PoorManOtp.GenericServer

  alias PoorManOtp.GenericServer
  alias PoorMan.Fibonacci

  def start() do
    GenericServer.start(__MODULE__, self(), %{})
  end

  def handle_cast({:compute, n}, state) do
    result =
      case Map.get(state, n) do
        nil -> Fibonacci.sequence(n)
        result -> result
      end

    new_state = Map.put_new(state, n, result)
    {:noreply, new_state}
  end

  def handle_call({:compute, n}, _parent, state) do
    result =
      case Map.get(state, n) do
        nil -> Fibonacci.sequence(n)
        result -> result
      end

    new_state = Map.put_new(state, n, result)
    {:reply, result, new_state}
  end

  def handle_info(message, state) do
    IO.inspect(binding())
    {:noreply, state}
  end
end
