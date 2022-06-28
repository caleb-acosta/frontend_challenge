defmodule FrontendChallengeWeb.Components.Chart do
  use Surface.LiveView
  alias FrontendChallengeWeb.Components.Employee
  alias FrontendChallenge.Hierachy

  data org_tree, :any, default: Hierachy.new()
  
  def render(assigns) do
    ~F"""
    <div class="chart">
      {#for employee <- @org_tree.data}
        <Employee id={employee.id} type={employee.type} depth={employee.depth_lev}/>
      {/for}  
      <button :on-click="add-employee" :values={type: :manager, parent: nil}>Add Manager</button> 
    </div>
    """
  end

  def handle_event("add-employee", values, socket) do
    {:noreply, 
      assign(
        socket, 
        org_tree: Hierachy.add(
          socket.assigns.org_tree, 
          str_to_int(values["parent"]), 
          :manager)
      )
    }
  end

  def handle_event("delete-employee", values, socket) do
    IO.inspect(values)
    {:noreply, 
      assign(
        socket, 
        org_tree: 
        Hierachy.delete_branch(
          socket.assigns.org_tree,
          str_to_int(values["employee-id"])) |> IO.inspect
      )
    }
  end

  def str_to_int(str) do
    try do                
      String.to_integer(str)   
    rescue                    
      _ -> nil
    end
  end
end
