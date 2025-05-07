# BoldApi

An Elixir library for interacting with the [Bold API](https://bold.co/).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `bold_api` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bold_api, "~> 0.1.0"}
  ]
end
```

## Setup

Create/get your [Bold API key](https://www.developers.bold.co/pagos-en-linea/llaves-de-integracion).
Add the following to your `config/config.exs`:

```elixir
config :bold_api,
  url: "https://integrations.api.bold.co", # optional
  key: "YOUR_BOLD_API_KEY"
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/bold_api>.
