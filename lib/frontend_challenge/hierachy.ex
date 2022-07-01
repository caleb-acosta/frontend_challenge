defmodule FrontendChallenge.Hierachy do
  @moduledoc """
    This module provides a set of functions to create, modify and update a department hierachy of FrontendChallenge.EmployeeStruc.
  """
  
  alias FrontendChallenge.EmployeeStruc

  defstruct data: [], current_id: 0

  @allocation [manager: 300, developer: 1000, tester: 500]

  def new(), do: %__MODULE__{}

  def add(hierachy, nil, :manager) do
    %__MODULE__{
      data: [
        %EmployeeStruc{
          id: hierachy.current_id,
          type: :manager,
          allocation: @allocation[:manager],
          total_allocation: @allocation[:manager]
        }
        | hierachy.data
      ],
      current_id: hierachy.current_id + 1
    }
  end

  def add(hierachy, parent_id, type) do
    parent_index = get_employee_index(hierachy, parent_id)

    Map.replace(
      hierachy,
      :data,
      List.replace_at(
        hierachy.data,
        parent_index,
        Map.update(
          get_employee_by_id(hierachy, parent_index),
          :children,
          [],
          &[hierachy.current_id | &1]
        )
      )
      |> List.insert_at(
        parent_index + 1,
        %EmployeeStruc{
          id: hierachy.current_id,
          type: type,
          depth_lev: Enum.at(hierachy.data, parent_index).depth_lev + 1,
          allocation: @allocation[type],
          total_allocation: @allocation[type]
        }
      )
    )
    |> Map.update(
      :current_id,
      hierachy.current_id,
      &(&1 + 1)
    )
    |> update_allocations()
    |> order_hierachy()
  end

  def get_children(hierachy, employee_id) do
    parent = get_employee_by_id(hierachy, employee_id)

    children =
      Enum.filter(hierachy.data, &(&1.id in parent.children))
      |> Enum.map(& &1.id)

    case children do
      [] ->
        []

      _ ->
        Enum.concat(children, Enum.map(children, &get_children(hierachy, &1))) |> List.flatten()
    end
  end

  def delete_branch(hierachy, employee_id) do
    to_delete = [employee_id | get_children(hierachy, employee_id)]

    Map.update(hierachy, :data, hierachy.data, fn d ->
      Enum.filter(d, &(&1.id not in to_delete))
    end)
    |> update_allocations()
    |> order_hierachy()
  end

  def get_employee_by_id(hierachy, id) do
    Enum.find(hierachy.data, &(&1.id == id))
  end

  def get_employee_index(hierachy, id) do
    Enum.find_index(hierachy.data, &(&1.id == id))
  end

  def order_hierachy(hierachy) do
    new_data =
      Enum.filter(hierachy.data, &(&1.depth_lev == 0))
      |> Enum.map(&[&1 | search_and_order_children(hierachy, &1)])
      |> List.flatten()

    Map.replace(hierachy, :data, new_data)
  end

  defp search_and_order_children(_, %EmployeeStruc{children: []}), do: []

  defp search_and_order_children(hierachy, employee) do
    Enum.filter(hierachy.data, &(&1.id in employee.children))
    |> Enum.sort(&(&1.id < &2.id))
    |> Enum.reduce(
      [],
      fn child, acc ->
        [child] ++ search_and_order_children(hierachy, child) ++ acc
      end
    )
  end

  defp update_allocations(hierachy) do
    new_data =
      Enum.filter(hierachy.data, &(&1.depth_lev == 0))
      |> Enum.reduce([], &[acc_total_allocation(hierachy, &1) | &2])
      |> List.flatten()

    Map.replace(hierachy, :data, new_data)
  end

  defp acc_total_allocation(_, %EmployeeStruc{children: []} = employee),
    do: Map.replace(employee, :total_allocation, employee.allocation)

  defp acc_total_allocation(hierachy, employee) do
    children =
      Enum.filter(hierachy.data, &(&1.id in employee.children))
      |> Enum.map(&acc_total_allocation(hierachy, &1))
      |> List.flatten()

    direct_children = Enum.filter(children, &(&1.id in employee.children))

    [
      Map.replace(
        employee,
        :total_allocation,
        Enum.reduce(direct_children, employee.allocation, &(&1.total_allocation + &2))
      )
      | children
    ]
  end

  def calc_total(hierachy) do
    Enum.reduce(hierachy.data, 0, &(&1.allocation + &2))
  end
end
