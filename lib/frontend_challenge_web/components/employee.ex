defmodule FrontendChallengeWeb.Components.Employee do
  use Surface.LiveComponent

  prop type, :atom
  prop depth, :integer
  prop root, :any 
  def render(assigns) do
    ~F"""
    
    <div
      style="border: 5px solid red; padding: 3px; margin: 3px; width: 30%;" 
    class="employee">
    {String.duplicate("------", @depth)}
      <button :on-click={"add-employee", target: "#chart"} :values={type: :manager, parent: assigns.id}>Employee: {assigns.id} Type: {@type}</button>
      <button :on-click={"delete-employee", target: "#chart"} :values={employee_id: assigns.id}>Delete</button>
    </div>
    """
  end
end
