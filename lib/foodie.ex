defmodule Foodie.Application do
  use Application

  @impl true
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    #i don't know what this is yet butt...
    Foodie.Metric.PrometheusExporter.setup()
    Foodie.Metric.PipelineInstrumenter.setup()
    Foodie.Metric.UserSessions.setup()

    children = [
      Foodie.Repo,
      {Phoenix.PubSub, name: Foodie.PubSub},
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Foodie.Plug,
        options: [
          port: String.to_integer("4001"),
          dispatch: dispatch(),
          protocol_options: [idle_timeout: :infinity]
        ]
      )
    ]

    opts = [strategy: :one_for_one, name: Foodie.Supervisor]

    # TODO: make these into tasks
    case Supervisor.start_link(children, opts) do
      {:ok, pid} ->
        start_up(pid)
        {:ok, pid}

      error ->
        error
    end

  end

  defp dispatch do
    [
      {:_,
       [
         {"/socket", Foodie.Plug.SocketHandler, []},
         {:_, Plug.Cowboy.Handler, {Foodie.Plug, []}}
       ]}
    ]
  end
  defp start_up(pid) do
    IO.inspect("omo I don start oooo")
    IO.inspect(pid)
    end
end
