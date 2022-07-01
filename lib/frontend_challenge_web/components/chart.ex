defmodule FrontendChallengeWeb.Components.Chart do
  use Surface.LiveView
  alias FrontendChallengeWeb.Components.Employee
  alias FrontendChallenge.Hierachy

  data org_tree, :any, default: Hierachy.new()
  data total_allocation, :integer, default: 0

  def render(assigns) do
    ~F"""
    <div class="container mt-6 box">
      <h2 class="is-size-3">Total: ${@total_allocation}</h2>
      <span class="button is-info" :on-click="add-employee" :values={type: :manager, parent: nil}>Add Manager</span>
      <div class="chart">
        {#for employee <- @org_tree.data}
          <Employee
            id={employee.id}
            type={employee.type}
            depth={employee.depth_lev}
            total_allocation={employee.total_allocation}
            allocation={employee.allocation}
          />
        {/for}
      </div>
    </div>
    """
  end

  def handle_event("add-employee", values, socket) do
    org_tree =
      Hierachy.add(
        socket.assigns.org_tree,
        str_to_int(values["parent"]),
        String.to_atom(values["type"])
      )

    total_allocation = Hierachy.calc_total(org_tree)
    {:noreply, assign(socket, org_tree: org_tree, total_allocation: total_allocation)}
  end

  def handle_event("delete-employee", values, socket) do
    org_tree =
      Hierachy.delete_branch(
        socket.assigns.org_tree,
        str_to_int(values["employee-id"])
      )

    total_allocation = Hierachy.calc_total(org_tree)
    {:noreply, assign(socket, org_tree: org_tree, total_allocation: total_allocation)}
  end

  def str_to_int(str) do
    try do
      String.to_integer(str)
    rescue
      _ -> nil
    end
  end
end
