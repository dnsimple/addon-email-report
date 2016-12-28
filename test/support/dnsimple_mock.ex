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
    {:ok, [
      %Dnsimple.Domain{account_id: 12437, auto_renew: true,
        created_at: "2014-05-15T22:49:02.532Z", expires_on: "2017-05-15", id: 126235,
        name: "campcoded.com", unicode_name: "campcoded.com", private_whois: false, registrant_id: 13468,
        state: "registered", token: "48L0YBnfhfgFH8L9zdZowpLn8vOfMRWdohNNFou9u",
        updated_at: "2016-04-16T18:05:39.309Z"},
      %Dnsimple.Domain{account_id: 12437, auto_renew: true,
        created_at: "2014-05-16T11:45:17.775Z", expires_on: "2017-05-16", id: 126291,
        name: "campcoded.de", unicode_name: "campcoded.de", private_whois: false, registrant_id: 13468,
        state: "registered", token: "48L0YBnfhfgFH8L9zdZowpLn8vOfMRWdohNNFou9u",
        updated_at: "2016-04-17T17:25:45.793Z"},
      %Dnsimple.Domain{account_id: 12437, auto_renew: false,
        created_at: "2016-11-07T15:45:39.578Z", expires_on: "2017-11-07", id: 264946,
        name: "tests-in.space", unicode_name: "tests-in.space", private_whois: false, registrant_id: 13468,
        state: "registered", token: "48L0YBnfhfgFH8L9zdZowpLn8vOfMRWdohNNFou9u",
        updated_at: "2016-11-07T15:45:50.224Z"}
    ]}
  end

  def get_domain(_client, _account_id, name) do
    {:ok, %Dnsimple.Response{data: %Dnsimple.Domain{name: name, unicode_name: name}}}
  end

  def list_email_forwards(_client, _account_id, _domain) do
    {:ok, %Dnsimple.Response{data: []}}
  end
end

defmodule EmailReports.Dnsimple.CertificatesMock do
  def list_certificates(_client, _account_id, _domain) do
     {:ok, %Dnsimple.Response{data: []}}
  end
end
