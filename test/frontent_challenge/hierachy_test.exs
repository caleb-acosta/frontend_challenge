defmodule FrontendChallenge.HierachyTests do
  use ExUnit.Case
  alias FrontendChallenge.Hierachy

  describe "FrontendChallenge.Hierachy" do
    test "new/0 creates a empty Hierachy Struct" do
      assert Hierachy.new() == %FrontendChallenge.Hierachy{current_id: 0, data: []}
    end 

    test "add/3 inserts a new node" do
      hierachy = Hierachy.new() |> Hierachy.add(nil, :manager)
      assert hierachy.data == 
        [
          %FrontendChallenge.EmployeeStruc{
            allocation: 300,
            children: [],
            depth_lev: 0,
            id: 0,
            total_allocation: 300,
            type: :manager
           }
        ]
      assert Hierachy.add(hierachy, 0, :manager).data ==
        [
          %FrontendChallenge.EmployeeStruc{
            allocation: 300,
            children: [1],
            depth_lev: 0,
            id: 0,
            total_allocation: 600,
            type: :manager
          },
          %FrontendChallenge.EmployeeStruc{
            allocation: 300,
            children: [],
            depth_lev: 1,
            id: 1,
            total_allocation: 300,
            type: :manager
          }
        ]
    end

    test "delete_branch/2 deletes the node and all descendants" do
      hierachy = 
        Hierachy.new 
        |> Hierachy.add(nil, :manager) 
        |> Hierachy.add(0, :manager) 
        |> Hierachy.add(1, :developer)

     assert Hierachy.delete_branch(hierachy, 0).data == []
    end
    
    test "calc_total/1 returns the total allocation of the hierachy" do
      hierachy = 
        Hierachy.new 
        |> Hierachy.add(nil, :manager) 
        |> Hierachy.add(0, :manager) 
        |> Hierachy.add(1, :developer)
        |> Hierachy.add(1, :tester)

      assert Hierachy.calc_total(hierachy) == 2100
    end
  
  end  
end
