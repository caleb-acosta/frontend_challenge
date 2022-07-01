defmodule FrontendChallengeWeb.Components.Separator do
  use Surface.Component

  prop length, :integer, default: 0

  def render(assigns) do
    ~F"""
    {#if @length >= 0}
      {#for _ <- 0..@length}
        <span class="depth_block" style="display: block;" />
      {/for}
    {/if}
    """
  end
end
