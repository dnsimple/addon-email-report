defmodule EmailReports.WebhookControllerTest do
  use EmailReports.ConnCase

  alias EmailReports.Webhook

  @zone_record_create ~s({"data": {"zone_record": {"id": 7226630, "ttl": 3600, "name": "www", "type": "CNAME", "content": "tests-in.space", "regions": ["global"], "zone_id": "tests-in.space", "priority": null, "parent_id": null, "created_at": "2016-12-19T11:30:01Z", "updated_at": "2016-12-19T11:30:01Z", "system_record": false}}, "name": "zone_record.create", "actor": {"id": "12437", "entity": "account", "pretty": "ole.michaelis@googlemail.com"}, "account": {"id": 12437, "display": "ole.michaelis", "identifier": "ole.michaelis@googlemail.com"}, "api_version": "v2", "request_identifier": "c61728c1-ce20-4e87-8821-ccfb638c5ad4"})
  @template_delete ~s({"data": {"template": {"id": 4241, "sid": "DSD", "name": "DSDSDSDD", "account_id": 12437, "created_at": "2016-12-19T11:13:29Z", "updated_at": "2016-12-19T11:13:29Z", "description": ""}}, "name": "template.delete", "actor": {"id": "14516", "entity": "user", "pretty": "ole.michaelis@googlemail.com"}, "account": {"id": 12437, "display": "ole.michaelis", "identifier": "ole.michaelis@googlemail.com"}, "api_version": "v2", "request_identifier": "b96322dd-70d9-423d-8d1e-5a61f75f1721"})
  @zone_record_delete ~s({"data": {"zone_record": {"id": 7029649, "ttl": 3600, "name": "", "type": "AAAA", "content": "2A03:B0C0:0003:00D0:0000:0000:224F:5001", "regions": ["global"], "zone_id": "tests-in.space", "priority": null, "parent_id": null, "created_at": "2016-12-14T11:28:35Z", "updated_at": "2016-12-14T11:28:35Z", "system_record": false}}, "name": "zone_record.delete", "actor": {"id": "12437", "entity": "account", "pretty": "ole.michaelis@googlemail.com"}, "account": {"id": 12437, "display": "ole.michaelis", "identifier": "ole.michaelis@googlemail.com"}, "api_version": "v2", "request_identifier": "5d83ab09-91aa-4b12-99be-28b4cb873a69"})

  test "GET /", %{conn: conn} do
    conn = put_req_header(conn, "content-type", "application/json")
    |> post(webhook_path(conn, :handle), @zone_record_delete)

    assert response(conn, 200)
    assert Repo.get_by(Webhook, %{account_id: 12437})
  end
end
