defmodule PoorManOtp.PoolQueue do
  use GenServer

  require Logger

  def start_link(worker: {mod, fun, args}, n_workers: n, name: name) do
    GenServer.start_link(__MODULE__, [{mod, fun, args}, n], name: name)
  end

  def init([{mod, fun, args}, n]) do
    queue =
      1..n
      |> Enum.to_list()
      |> Enum.map(fn _n ->
        {:ok, pid} = :erlang.apply(mod, fun, [args])
        %{pid: pid}
      end)

    {:ok, %{queue: queue, worker: {mod, fun, args}}}
  end

  def handle_call(:get, _from, %{queue: queue} = state), do: {:reply, {:ok, queue}, state}
end
