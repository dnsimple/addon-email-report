defmodule EmailReports.ReportEmail do
  use Phoenix.Swoosh, view: EmailReports.EmailView, layout: {EmailReports.LayoutView, :email}
  use Timex

  alias EmailReports.Dnsimple

  def simple(user) do
    account = build_accout user.token
    domains = Dnsimple.domains(account)
    |> Enum.map(&(Task.async(__MODULE__, :enrich_domain, [&1, account])))
    |> Enum.map(&Task.await/1)
    new
    |> to(user.email)
    |> from(config(:report_from))
    |> reply_to(config(:report_reply_to))
    |> subject("Your monthly DNSimple report!")
    |> render_body("simple.html", %{user: user, domains: domains})
  end

  def build_accout(token) do
    identidy = Dnsimple.whoami(%{:dnsimple_access_token => token})
    %{
      :dnsimple_access_token => token,
      :dnsimple_account_id => identidy.account.id,
    }
  end

  def enrich_domain(domain, account) do
    certs_task = Task.async(fn -> Dnsimple.certificates(account, domain.name) end)
    fwd_task = Task.async(fn -> Dnsimple.email_forwards(account, domain.name) end)
    {
      domain,
      Task.await(certs_task) |> Enum.filter(&(active_certificate?(&1))),
      Task.await(fwd_task)
    }
  end

  defp active_certificate?(certs) do
    certs.expires_on
    |> Timex.parse!("{YYYY}-{0M}-{0D}")
    |> Timex.compare(Timex.today)
    |> Kernel.>(0)
  end

  defp config(key) do
    Application.get_env(:email_reports, key)
  end
end
