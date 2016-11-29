defmodule EmailReports.ReportEmail do
  use Phoenix.Swoosh, view: EmailReports.EmailView, layout: {EmailReports.LayoutView, :email}

  def simple(user) do
    new
    |> to({user.name, user.email})
    |> from(config(:report_from))
    |> reply_to(config(:report_reply_to))
    |> subject("Hello, Avengers!")
    |> render_body("welcome.html", %{username: user.username})
  end

  defp config(key) do
    Application.get_env(:email_reports, key)
  end
end
