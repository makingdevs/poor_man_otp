defmodule PoorManOtp.Application do
  use Application

  def start(_type, _args) do
    children = []
    opts = [strategy: :one_for_one, name: PoorManOtp.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
