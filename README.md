# DNSimple E-Mail Reports add-on

This is a [DNSimple add-on](https://developer.dnsimple.com) to send out montly reports to all users optin-in into this add-on.

## Development

The E-Mail add-on is a [Elixir](http://elixir-lang.org) [Phoenix](http://www.phoenixframework.org) application. You will need *Elixir (~> 1.3)* and *Postgres (~> 9.4)* to run this.

To start the Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Tests

After you followed the steps above use `mix test` to run the tests.

## See E-Mails in development

Start the app as usual `mix phoenix.server` and then visit: http://localhost:4000/mailbox/
