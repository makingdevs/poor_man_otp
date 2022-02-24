defmodule PoorMan.FibonacciServer do
  @moduledoc """
  Make the Fibonacci Sequence a Server
  """

  alias PoorManOtp.GenericServer

  def start() do
    GenericServer.start(__MODULE__)
  end
end
