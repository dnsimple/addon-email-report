defmodule EmailReports.ReportEmail do
  use Phoenix.Swoosh, view: EmailReports.EmailView, layout: {EmailReports.LayoutView, :email}

  def simple(user) do
    new
    |> to(user.email)
    |> from(config(:report_from))
    |> reply_to(config(:report_reply_to))
    |> subject("Your monthly DNSimple report!")
    |> render_body("simple.html", %{user: user})
  end

  defp config(key) do
    Application.get_env(:email_reports, key)
  end
end
