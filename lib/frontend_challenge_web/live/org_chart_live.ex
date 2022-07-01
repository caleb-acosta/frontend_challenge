defmodule FrontendChallengeWeb.DepChartLive do
  @moduledoc """
    This module renders a LiveView of a employees hierachy tree. 
  """

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
