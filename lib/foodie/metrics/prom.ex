defmodule Foodie.Metric.PipelineInstrumenter do
  use Prometheus.PlugPipelineInstrumenter

  def label_value(:request_path, conn) do
    conn.request_path
  end
end

defmodule Foodie.Metric.PrometheusExporter do
  use Prometheus.PlugExporter
end

defmodule Foodie.Metric.UserSessions do
  use Prometheus.Metric

  def setup do
    Gauge.declare(
      name: :user_sessions,
      help: "Number of user sessions running"
    )
  end

  def set(n) do
    Gauge.set([name: :user_sessions], n)
  end
end
