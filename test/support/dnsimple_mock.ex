defmodule EmailReports.Dnsimple.OauthMock do
  def exchange_authorization_for_token(_client, _attributes) do
    {:ok, %Dnsimple.Response{data: %{access_token: "access-token", account_id: "1234"}}}
  end
end

defmodule EmailReports.Dnsimple.IdentityMock do
  def whoami(_client) do
    {:ok, %Dnsimple.Response{data: %{account: %{id: 1, email: "user@example.com"}}}}
  end
end

defmodule EmailReports.Dnsimple.DomainsMock do
  def list_domains(_client, _opts) do
    {:ok, %Dnsimple.Response{data: []}}
  end

  def all_domains(_client, _opts) do
    {:ok, []}
  end

  def get_domain(_client, _account_id, name) do
    {:ok, %Dnsimple.Response{data: %Dnsimple.Domain{name: name}}}
  end
end
