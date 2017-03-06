# CouchjitsuTrack

## Building
Track is an Elixir Phoenix back end with some jQuery for the front end. To build & run the application, you'll need to install Elixir and Phoenix.  The [Phoenix Framework](http://www.phoenixframework.org/docs/installation) website has a good introduction in how to install it.

In addition to Elixir, you'll need a [Postgres](https://www.postgresql.org/download/) instance installed locally. 

After those stps are done, you can launch the application by:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
