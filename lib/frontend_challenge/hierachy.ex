defmodule FrontendChallenge.EmployeeStruc do
  defstruct id: nil, type: nil, depth_lev: 0, children: []
end

defmodule FrontendChallenge.Hierachy do
  alias FrontendChallenge.EmployeeStruc

  defstruct data: [], current_id: 0

  def new(), do: %__MODULE__{}

  def add(chart, nil, type) do
    %__MODULE__{
      data: [
        %EmployeeStruc{
          id: chart.current_id, 
          type: type} 
        | chart.data],
      current_id: chart.current_id + 1}
  end 

  def add(chart, parent_id, type) do
    parent_index = Enum.find_index(chart.data, &(&1.id == parent_id))
    Map.update(
      chart,
      :data,
      chart.data,
      fn d -> 
        List.update_at(
          d, 
          parent_index, 
          fn parent -> 
            Map.update(
              parent, 
              :children, 
              [], 
              &([chart.current_id | &1])) 
          end)
          |> IO.inspect
        |> List.insert_at(
          parent_index + 1, 
          %EmployeeStruc{
            id: chart.current_id, 
            type: type, 
            depth_lev: Enum.at(chart.data, parent_index).depth_lev + 1 })
        |> IO.inspect
      end)
    |> Map.update(
      :current_id,
      chart.current_id,
      &(&1 + 1)
    )
  end 

  def get_children(chart, employee_id) do
    parent = Enum.find(chart.data, &(&1.id == employee_id))
    children =  
    Enum.filter(chart.data, &(&1.id in parent.children))
    |> Enum.map(&(&1.id))
    case children do
      [] -> []
      _ -> Enum.concat(children, Enum.map(children, &(get_children(chart, &1)))) |> List.flatten
    end
  end

  def delete_branch(chart, employee_id) do
    to_delete = [employee_id | get_children(chart, employee_id)]
    Map.update(chart, :data, chart.data, fn d -> Enum.filter(d, &(&1.id not in to_delete)) end)
  end
end
