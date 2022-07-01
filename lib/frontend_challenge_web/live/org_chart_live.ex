defmodule FrontendChallengeWeb.DepChartLive do
  use Surface.LiveView

  alias FrontendChallengeWeb.Components.Chart

  def render(assigns) do
    ~F"""
    <div>
      <Chart id="chart" />
    </div>
    """
  end
end
