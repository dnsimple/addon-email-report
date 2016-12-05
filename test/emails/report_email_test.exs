defmodule EmailReports.ReportEmailTest do
  use ExUnit.Case, async: true

  alias EmailReports.ReportEmail

  setup do
    user = %{email: "user@example.com"}
    {:ok, user: user}
  end

  describe "EmailReports.ReportEmail/1" do
    test "sent to user mail without name", %{user: user} do
      mail = ReportEmail.simple user
      assert mail.to == [{"", user.email}]
    end

    test "sent from the correct user", %{user: user} do
      mail = ReportEmail.simple user
      assert mail.from == {"Trusty form DNSimple", "trusty@dnsimple.com"}
    end

    test "sets correct reply to adress", %{user: user} do
      mail = ReportEmail.simple user
      assert mail.reply_to == {"DNSimple Support", "support@dnsimple.com"}
    end

    test "sets correct topic", %{user: user} do
      mail = ReportEmail.simple user
      assert mail.subject == "Your monthly DNSimple report!"
    end

    test "mail has correct greeting", %{user: user} do
      mail = ReportEmail.simple user
      assert mail.html_body =~ "Welcome to Sample, #{user.email}!"
    end
  end
end
