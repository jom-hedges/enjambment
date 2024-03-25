defmodule Enjambment.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EnjambmentWeb.Telemetry,
      Enjambment.Repo,
      {DNSCluster, query: Application.get_env(:enjambment, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Enjambment.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Enjambment.Finch},
      # Start a worker by calling: Enjambment.Worker.start_link(arg)
      # {Enjambment.Worker, arg},
      # Start to serve requests, typically the last entry
      EnjambmentWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Enjambment.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EnjambmentWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
