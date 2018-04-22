# XConf

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `(cd assets && npm install)`
  * Seed the database with `mix run priv/repo/seeds.exs`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Db setup

```bash
# configure db params if needed, refer to config/dev.exs, create config/dev.secret.db.exs
mix ecto.setup
```

### Seed conf data

download

* `speaker.yml` from https://github.com/rubytaiwan/rubyelixirconftw2018.github.io/blob/develop/data/speaker.yml
* `program.yml` from https://github.com/rubytaiwan/rubyelixirconftw2018.github.io/blob/develop/data/program.yml

```
mix run priv/repo/seeds.exs path/to/speaker.yml path/to/program.yml
```

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
