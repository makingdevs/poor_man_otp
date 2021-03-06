defmodule PoorManOtp.GenericServer do
  @moduledoc """
  A Generic implementation for process as Servers
  """

  @callback handle_cast(msg :: tuple(), state :: any()) :: {:noreply, any()}
  @callback handle_call(msg :: tuple(), parent :: pid(), state :: any()) :: {:reply, any(), any()}
  @callback handle_info(msg :: tuple(), state :: any()) :: {:noreply, any()}

  @doc """
  Creates a process with a server behavior
  """
  def start(module, parent, init \\ []) do
    # Process.flag(:trap_exit, true)
    # spawn_link(__MODULE__, :loop, [module, parent, init])
    {pid, _reference} = spawn_monitor(__MODULE__, :loop, [module, parent, init])
    pid
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
    send(pid_server, {:call, message})

    receive do
      msg -> msg
    end
  end

  @doc """
  The main function of the process
  """
  def loop(module, parent, state) do
    receive do
      {:cast, message} ->
        {:noreply, new_state} = module.handle_cast(message, state)
        loop(module, parent, new_state)

      {:call, message} ->
        {:reply, result, new_state} = module.handle_call(message, parent, state)
        send(parent, result)
        loop(module, parent, new_state)

      message ->
        {:noreply, new_state} = module.handle_info(message, state)
        loop(module, parent, new_state)
    end
  end
end
