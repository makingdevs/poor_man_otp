defmodule PoorManOtp.GenericServer do
  @moduledoc """
  A Generic implementation for process as Servers
  """

  @callback handle_cast(msg :: tuple(), parent :: pid(), state :: any()) :: any()

  @doc """
  Creates a process with a server behavior
  """
  def start(module, parent, init \\ []) do
    spawn(__MODULE__, :loop, [module, parent, init])
  end

  @doc """
  Make async calls to the process
  """
  def cast(pid_server, message) do
    send(pid_server, {:cast, message})
  end

  @doc """
  Make sync calls to the process
  """
  def call(pid_server, message) do
  end

  @doc """
  The main function of the process
  """
  def loop(module, parent, state) do
    receive do
      :kill ->
        :killed

      {:cast, message} ->
        {:ok, result, new_state} = module.handle_cast(message, parent, state)
        send(parent, {:ok, {module, message, result, new_state}})
        loop(module, parent, new_state)
    end
  end
end
