defmodule FrontendChallengeWeb.DepChartLive do
  use Surface.LiveView

  alias FrontendChallengeWeb.Components.{Employee, Chart}

  def render(assigns) do
    ~F"""
    <div>
      <Chart id="chart"/>    
    </div>
    """
  end
end
