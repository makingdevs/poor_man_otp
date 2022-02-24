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

  def handle_message({:compute, n}, _parent, state) do
    result =
      case Map.get(state, n) do
        nil -> Fibonacci.sequence(n)
        result -> result
      end

    new_state = Map.put_new(state, n, result)
    {:ok, result, new_state}
  end
end
