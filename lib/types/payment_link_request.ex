defmodule BoldApi.Types.PaymentLinkRequest do
  @moduledoc """
  PaymentLink request struct.
  """
  alias BoldApi.Types.Tax

  @type amount :: %{
          currency: String.t(),
          taxes: list(Tax.t()),
          total_amount: float(),
          tip_amount: float()
        }

  @type t :: %__MODULE__{
          amount_type: :open | :close,
          amount: amount(),
          description: String.t(),
          expiration_date: integer(),
          callback_url: String.t(),
          payment_methods: list(String.t()),
          payer_email: String.t(),
          image_url: String.t()
        }

  @enforce_keys [:amount_type]
  defstruct [
    :amount_type,
    :amount,
    :description,
    :expiration_date,
    :callback_url,
    :payment_methods,
    :payer_email,
    :image_url
  ]
end
