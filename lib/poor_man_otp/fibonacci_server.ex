defmodule PoorMan.FibonacciServer do
  @moduledoc """
  Make the Fibonacci Sequence a Server
  """

  @behaviour PoorManOtp.GenericServer

  alias PoorManOtp.GenericServer
  alias PoorMan.Fibonacci

  def start() do
    GenericServer.start(__MODULE__)
  end

  def handle_message({:compute, n}, state) do
    result = Fibonacci.sequence(n)
    {:ok, result, state}
  end
end
