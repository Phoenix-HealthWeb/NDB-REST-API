defmodule NdbRestApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NdbRestApiWeb.Telemetry,
      NdbRestApi.Repo,
      {Ecto.Migrator,
       repos: Application.fetch_env!(:ndb_rest_api, :ecto_repos), skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:ndb_rest_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: NdbRestApi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: NdbRestApi.Finch},
      # Start a worker by calling: NdbRestApi.Worker.start_link(arg)
      # {NdbRestApi.Worker, arg},
      # Start to serve requests, typically the last entry
      NdbRestApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NdbRestApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NdbRestApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    IO.puts("to mare kea vaka")
    IO.puts(System.get_env("FORCE_MIGRATIONS"))
    # By default, sqlite migrations are run when using a release
    # Additionally, migrations are made if we set the FORCE_MIGRATIONS
    System.get_env("RELEASE_NAME") != nil &&
      System.get_env("FORCE_MIGRATIONS") != "true"
  end
end
