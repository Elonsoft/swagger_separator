# SwaggerSeparator

Separates swagger definitions from controller when used.

## Example

```
  defmodule MyApp.PageController do
    use SwaggerSeparator

    def index(conn, _params) do
      # some work here...
    end
  end

  defmodule MyApp.PageSwagger do
    use PhoenixSwagger

    swagger_path :index do
      get "/page"
      summary("Request to a page")

      response(200, "Ok")
    end
  end
```

In the example above all definitions from `MyApp.PageSwagger` will be
put in `MyApp.PageController` module. All you need to do is define a
module with the same name as a controller module, but with 'Swagger'
ending instead of 'Controller'.

## Installation

```elixir
def deps do
  [
    {:swagger_separator, git: "<link to this repo>", commit: "last commit"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/swagger_separator](https://hexdocs.pm/swagger_separator).
