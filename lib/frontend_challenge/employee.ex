defmodule FrontendChallenge.EmployeeStruc do
  @moduledoc """
    This module provides a Struct of an Employee to build a Hierachy tree.
  """
  defstruct id: nil, type: nil, depth_lev: 0, children: [], allocation: 0, total_allocation: 0
end
