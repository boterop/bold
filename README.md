# Bold

An Elixir library for interacting with the [Bold API](https://bold.co/).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `bold` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bold, "~> 0.1.0"}
  ]
end
```

## Setup

Create/get your [Bold API key](https://www.developers.bold.co/pagos-en-linea/llaves-de-integracion).
Add the following to your `config/config.exs`:

```elixir
config :bold,
  url: "https://integrations.api.bold.co", # optional
  key: "YOUR_BOLD_API_KEY"
```

## Usage

```elixir
# Create a close payment link
{:ok, %Bold.Types.PaymentLinkResponse{}} =
  %Bold.Types.PaymentLinkRequest{
    amount_type: :close,
    description: "Payment for order order-id",
    payer_email: "test@example.org",
    amount: %{
      currency: "COP",
      tip_amount: 0,
      taxes: [%{value: 1597, base: 8403, type: "VAT"}],
      total_amount: 10000
    },
    callback_url: "https://example.org/return",
    expiration_date: nil,
    image_url: "https://example.org/image.png"
  } |> Bold.create_link()

# Create an open payment link
{:ok, %Bold.Types.PaymentLinkResponse{}} =
  %Bold.Types.PaymentLinkRequest{
    amount_type: :open,
    description: 'Payment for order order-id',
    payer_email: 'test@example.org',
    callback_url: 'https://example.org/return',
    expiration_date: nil,
  } |> Bold.create_link()

# Get a payment link
{:ok, %Bold.Types.PaymentStatusResponse{}} =
  Bold.get_link("LNK_3N09Z1EP0Y")

# List payment methods
{:ok, %Bold.Types.PaymentMethodsResponse{}} =
  Bold.list_methods()
```
