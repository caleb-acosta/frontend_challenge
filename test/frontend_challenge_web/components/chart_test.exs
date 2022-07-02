defmodule FrontendChallengeWeb.Components.ChartTest do
  use ExUnit.Case
  use Surface.LiveViewTest
  use FrontendChallengeWeb.ConnCase
  import Phoenix.LiveViewTest
  @endpoint FrontendChallengeWeb.Endpoint

  test "Chart render/1 renders the root Chart element", %{conn: conn} do
    conn = get(conn, "/chart")
    assert html_response(conn, 200) =~ "<div class=\"chart\">"

    {:ok, view, _html} = live(conn)

    html = view
      |> element(".button, .is-info")
      |>render_click() 
      
    assert html =~ "manager 0"
    
    html = view
      |> element("button.mx-1:nth-child(4)")
      |> render_click()

    refute html =~ "manager 0"
    
  end

end
