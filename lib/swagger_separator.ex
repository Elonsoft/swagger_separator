defmodule SwaggerSeparator do
  @moduledoc """
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
  """

  defmacro __using__(_opts) do
    swagger_module =
      __CALLER__.module
      |> to_string()
      |> String.reverse()
      |> case do
        <<"rellortnoC", name::binary>> ->
          common = name |> String.reverse()
          (common <> "Swagger") |> String.to_atom()

        _ ->
          raise "Your controller module name should end with 'Controller'."
      end

    definitions = swagger_module.__info__(:functions)

    for {name, argc} <- definitions do
      args = gen_args(argc)

      quote do
        defdelegate unquote(name)(unquote_splicing(args)),
          to: unquote(swagger_module),
          as: unquote(name)
      end
    end
  end

  defp gen_args(0), do: []

  defp gen_args(count) when count > 0 do
    Enum.map(1..count, fn n ->
      name = ("arg" <> to_string(n)) |> String.to_atom()
      {name, [], Elixir}
    end)
  end
end
