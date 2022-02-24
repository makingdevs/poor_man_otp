defmodule PoorManOtp.GenericServer do
  @moduledoc """
  A Generic implementation for process as Servers
  """

  @callback handle_message(msg :: tuple(), state :: any()) :: any()

  @doc """
  Creates a process with a server behavior
  """
  def start(module) do
    spawn(__MODULE__, :loop, [module, %{}])
  end

  @doc """
  The main function of the process
  """
  def loop(module, state) do
    receive do
      {message, pid} ->
        {:ok, result, state} = module.handle_message(message, state)
        send(pid, {:ok, {module, message, result, state}})
        loop(module, state)

      :kill ->
        :killed

      _ ->
        loop(module, state)
    end
  end
end
