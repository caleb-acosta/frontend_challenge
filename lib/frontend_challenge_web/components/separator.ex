defmodule FrontendChallengeWeb.Components.Separator do
  
  @moduledoc """
    This module renders a separator to represent depth levels in a Hierachy tree.
  """

  use Surface.Component

  prop length, :integer, default: 0

  def render(assigns) do
    ~F"""
    {#if @length >= 0}
      {#for _ <- 0..@length}
        <span class="depth_block"/>
      {/for}
    {/if}
    """
  end
end
