defmodule EmailReports.EmailViewTest do
  use EmailReports.ConnCase, async: true

  alias EmailReports.EmailView

  test "expires renders the date in a human readablwe format" do
    assert EmailView.expires("2016-10-25") == "10/25/2016"
  end

end
