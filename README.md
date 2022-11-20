# Twytter

**NOTE: This is an exercise for the students of NSWI106.**

Twitter is not doing great, so it's time to look for replacements. So, I wrote
Twytter. It didn't even cost 43 billion, more like 43 minutes. You get what you
pay for.

## What is this?

This is a rather trivial Go application: a simple HTTP API which allows you to
read and write twytts (think tweets).

## Building and running

To build the app, you need Go 1.19 or later installed. Then, you can simply run:

```
% go build .
```

This will create an executable in the working directory. You can run that (but
audit the code first!):

```
% ( . ./env.dev && ./twytter )
```

The application is configured through environment variables, see `env.dev` for
details.

The `env.dev` file contains some default values for the variables which I used
while testing the app on my machine. The app won't run on your machine,
unless you set up your database server first.

Please note that the application doesn't create a database schema for itself.
You need to create it manually. The required schema is contained in `schema.sql`.
It's just a single table. You can use `psql` to connect to the database server
and run the commands from `schema.sql`.

## API

The application provides two API endpoints:

- `GET /twytts`: returns all twytts for all users.

Example:

```
% curl -s localhost:8080/twytts | jq .
[
  {
    "ID": 1,
    "Name": "dcepelik",
    "Twytt": "Foobar 1"
  },
  {
    "ID": 2,
    "Name": "dcepelik",
    "Twytt": "Foobar 2"
  }
]
```

- `POST /twytts`: creates a new twytt.

Example:

```
~/mff/linux-adm/cont/twytter% curl -s --json '{"Name": "dcepelik", "Twytt": "Foobar 3"}' localhost:8080/twytts | jq .
{
  "ID": 3,
  "Name": "dcepelik",
  "Twytt": "Foobar 3"
}
```

## Bonus assignment

For 30 bonus points, you can add two new API endpoints:

- `DELETE /twytts/<id>`, which deletes a twytt with the given ID.
- `PUT /twytts/<id>`, which edits a twytt.

The DB boilerplate code is generated with [sqlc], and you'll need to regenerate
it while making the changes. A simple way to do it is

```
% podman run --rm -v $(pwd):/src -w /src kjconroy/sqlc generate
```

(in the root of the repo).

[sqlc]: https://docs.sqlc.dev/en/latest/tutorials/getting-started-postgresql.html
