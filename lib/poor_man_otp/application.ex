defmodule PoorManOtp.Application do
  use Application

  def start(_type, _args) do
    children = [
      Supervisor.child_spec(
        {PoorManOtp.PoolQueue,
         [
           worker: {PoorMan.FibonacciGenServer, :start_link, []},
           n_workers: 3,
           name: PoolFibonacci
         ]},
        id: :worker_fibonacci
      )
    ]

    opts = [strategy: :one_for_one, name: PoorManOtp.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
