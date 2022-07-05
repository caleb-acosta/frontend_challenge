defmodule FrontendChallengeWeb.Components.EmployeeTest do
  use ExUnit.Case
  use Surface.LiveViewTest
  use FrontendChallengeWeb.ConnCase
  @endpoint FrontendChallengeWeb.Endpoint

  test "creates a Employee with the given assigns" do
    e = %FrontendChallenge.EmployeeStruc{id: 3, type: :manager, depth_lev: 2, children: [], allocation: 300, total_allocation: 1800}

    html =
    render_surface do
      ~F"""
      <FrontendChallengeWeb.Components.Employee id={e.id} type={e.type} depth={e.depth_lev} allocation={e.allocation} total_allocation={e.total_allocation}/>
      """
    end

    assert html =~ """
    <span class="mr-auto is-size-5">manager 3</span>
    """
    assert html =~ """
    <span>Warranted Allocation: $300</span>
    """
    assert html =~ """
    <span>Monthly accumulated allocation: $1800</span>
    """
  end  

  test "Toggle buttons", %{conn: conn} do
    conn = get(conn, "/chart")
    assert html_response(conn, 200) =~ "<div class=\"chart\">"

    {:ok, view, _html} = live(conn)

    view
      |> element(".button, .is-info")
      |> render_click()
    html =
    view  
      |> element("button.mx-1:nth-child(2)")
      |> render_click()
   
    assert html =~ "<div class=\"is-flex p-2 is-flex-direction-column add-box\">"
    
    html =
    view  
      |> element("button.mx-1:nth-child(3)")
      |> render_click()
   
    assert html =~ "div class=\"is-flex is-flex-direction-column allocation-box\">"
  end
end
