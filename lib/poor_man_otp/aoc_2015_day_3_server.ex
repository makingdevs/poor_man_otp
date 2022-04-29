defmodule PoorMan.AOC2015.Day3Server do
  @moduledoc """
  Make the AOC2015.Day3 a Server
  """

  alias PoorManOtp.GenericServer

  def start() do
    GenericServer.start(__MODULE__, self())
  end
end
