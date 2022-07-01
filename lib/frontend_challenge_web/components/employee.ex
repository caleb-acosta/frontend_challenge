defmodule FrontendChallengeWeb.Components.Employee do
  
  @moduledoc """
    This module renders a stateful LiveComponent of an employee in a Hierachy Tree
  """

  use Surface.LiveComponent
  alias FrontendChallengeWeb.Components.Separator

  prop type, :atom
  prop depth, :integer
  prop allocation, :integer
  prop total_allocation, :integer

  data toggle_add, :boolean, default: true
  data toggle_allocation, :boolean, default: true

  def render(assigns) do
    ~F"""
    <div class="is-flex my-2">
      <Separator length={@depth} />
      <div class="employee box">
        <div class="is-flex is-align-items-center">
          <span class="mr-auto is-size-5">{@type} {assigns.id}</span>
          {#if @type == :manager}
            <button class="mx-1 my-0 button is-primary" :on-click="toggle-add"><i class="fa-solid fa-angle-down" /></button>
          {/if}
          <button class="mx-1 my-0 button is-info" :on-click="toggle-allocation"><i class="fa-solid fa-dollar-sign" /></button>
          <button
            class="mx-1 my-0 button is-danger"
            :on-click={"delete-employee", target: "#chart"}
            :values={employee_id: assigns.id}
          ><i class="fa-solid fa-trash" /></button>
        </div>
        <div class={"is-flex", "is-flex-direction-column", "is-hidden": @toggle_allocation}>
          <span>Warranted Allocation: ${@allocation}</span>
          {#if @type == :manager}
            <span>Monthly accumulated allocation: ${@total_allocation}</span>
          {/if}
        </div>
        <div class={"is-flex", "p-2", "is-flex-direction-column", "is-hidden": @toggle_add}>
          <span
            class="button is-success"
            :on-click={"add-employee", target: "#chart"}
            :values={type: :manager, parent: assigns.id}
          >+ Manager</span>
          <span
            class="button is-success"
            :on-click={"add-employee", target: "#chart"}
            :values={type: :developer, parent: assigns.id}
          >+ Developer</span>
          <span
            class="button is-success"
            :on-click={"add-employee", target: "#chart"}
            :values={type: :tester, parent: assigns.id}
          >+ QA Tester</span>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("toggle-add", _, socket),
    do: {:noreply, assign(socket, toggle_add: !socket.assigns.toggle_add)}

  def handle_event("toggle-allocation", _, socket),
    do: {:noreply, assign(socket, toggle_allocation: !socket.assigns.toggle_allocation)}
end
