defmodule Mix.Tasks.Reports.Send do
  use Mix.Task

  require Logger

  alias Ecto.DateTime
  alias EmailReports.Repo

  import Mix.Ecto
  import Ecto.Query

  @shortdoc "Sends out all pending reports"

  def run(_) do
    {:ok, pid, _} = ensure_started(EmailReports.Repo, [])
    Application.ensure_all_started(:dnsimple)
    Application.ensure_all_started(:swoosh)

    one_month_ago = %{DateTime.utc | month: DateTime.utc.month - 1}
    Repo.all(
      from s in EmailReports.Subscription,
       where: s.last_sent < ^one_month_ago,
       or_where: is_nil(s.last_sent),
       select: s
    )
    |> Enum.map(&send_mail/1)
  end

  defp send_mail(%EmailReports.Subscription{} = subscription) do
    dnsimple_account = account(subscription)
    |> EmailReports.Dnsimple.whoami
    |> Map.get(:account)

    Logger.info "Sending mail to subscription id: #{subscription.id} (#{dnsimple_account.email})"

    EmailReports.ReportEmail.simple(%{email: dnsimple_account.email, token: subscription.access_token})
    |> EmailReports.Mailer.deliver
  end

  defp account(%EmailReports.Subscription{account_id: account_id, access_token: access_token}) do
    %{
      :dnsimple_access_token => access_token,
      :dnsimple_account_id => account_id,
    }
  end
end
