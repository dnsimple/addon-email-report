defmodule EmailReports.ReportEmailTest do
  use ExUnit.Case, async: true
  use Timex

  alias EmailReports.ReportEmail

  setup do
    user = %{email: "user@example.com", token: "1234abcdf"}
    {:ok, user: user, mail: ReportEmail.simple(user)}
  end

  describe "simple/1" do
    test "sent to user mail without name", %{user: user, mail: mail} do
      assert mail.to == [{"", user.email}]
    end

    test "sent from the correct user", %{mail: mail} do
      assert mail.from == {"Trusty form DNSimple", "trusty@dnsimple.com"}
    end

    test "sets correct reply to adress", %{mail: mail} do
      assert mail.reply_to == {"DNSimple Support", "support@dnsimple.com"}
    end

    test "sets correct topic", %{mail: mail} do
      assert mail.subject == "Your monthly DNSimple report!"
    end

    test "mail has the domain list", %{mail: mail} do
      assert mail.html_body =~ "example.com"
    end
  end

  describe "find_expiring_domains/1" do
    test "all expires next 30 days" do
      domains = [
        build_domain("domain.tld", date_from_now(7))
      ]

      assert ReportEmail.filter_expiring_domains(domains) == domains
    end

    test "some expires next 30 days" do
      domains = [
        foo = build_domain("foo.com", date_from_now(7)),
        build_domain("example.com", date_from_now(100))
      ]

      assert ReportEmail.filter_expiring_domains(domains) == [foo]
    end

    test "none expire" do
      domains = [
        build_domain("foo.com", date_from_now(110)),
        build_domain("example.com", date_from_now(100))
      ]

      assert ReportEmail.filter_expiring_domains(domains) == []
    end

  end

  defp date_from_now(days) do
    DateTime.utc_now
    |> Timex.add(Duration.from_days(days))
    |> DateTime.to_date
  end

  defp build_domain(name, expires) do
    %Dnsimple.Domain{account_id: 12437, auto_renew: true,
      created_at: "2014-05-15T22:49:02.532Z", expires_on: Date.to_iso8601(expires), id: 126235,
      name: name, private_whois: false, registrant_id: 13468,
      state: "registered", token: "48L0YBnfhfgFH8L9zdZowpLn8vOfMRWdohNNFou9u",
      updated_at: "2016-04-16T18:05:39.309Z"}
  end
end
