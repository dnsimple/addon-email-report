defmodule EmailReports.ReportEmailTest do
  use ExUnit.Case, async: true

  alias EmailReports.ReportEmail

  setup do
    user = %{email: "user@example.com", token: "1234abcdf"}
    {:ok, user: user, mail: ReportEmail.simple(user)}
  end

  describe "EmailReports.ReportEmail/1" do
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

    test "mail has correct greeting", %{user: user, mail: mail} do
      assert mail.html_body =~ "Welcome to Sample, #{user.email}!"
    end

    test "mail has the domain list", %{mail: mail} do
      assert mail.html_body =~ "example.com"
    end
  end
end
