defmodule EmailReports.ReportEmail do
  use Phoenix.Swoosh, view: EmailReports.EmailView, layout: {EmailReports.LayoutView, :email}
  use Timex

  alias EmailReports.Dnsimple

  def simple(user) do
    account = build_accout user.token
    domains = account
    |> Dnsimple.domains
    |> Enum.map(&(Task.async(__MODULE__, :enrich_domain, [&1, account])))
    |> Enum.map(&Task.await/1)

    new()
    |> to(user.email)
    |> from(config(:report_from))
    |> reply_to(config(:report_reply_to))
    |> subject("Your monthly DNSimple report!")
    |> render_body("simple.html", %{
        user: user,
        domains: domains,
        expiring_domains: filter_expiring_domains(Enum.map(domains, &(elem(&1, 0)))),
        expiring_certificates: filter_expiring_certificates(Enum.map(domains, &(elem(&1, 1)))),
        did_you_know: Enum.random Application.get_env(:email_reports, :did_you_know)
      })
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
      certs_task |> Task.await |> Enum.filter(&(active_certificate?(&1))),
      Task.await(fwd_task)
    }
  end

  def filter_expiring_domains(domains) do
    Enum.filter(domains, &(expires_within_next_month?(&1.expires_on)))
  end

  def filter_expiring_certificates(certs) do
    certs
    |> Enum.filter(fn cert -> length(cert) > 0 end)
    |> Enum.flat_map(&(&1))
    |> Enum.filter(&(expires_within_next_month?(&1.expires_on)))
  end

  defp expires_within_next_month?(nil), do: false
  defp expires_within_next_month?(date) when is_binary(date) do
    next_month = Timex.add(DateTime.utc_now, Duration.from_days(30))
    date
    |> Date.from_iso8601!
    |> Timex.compare(next_month)
    |> Kernel.<(0)
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
