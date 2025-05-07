defmodule BoldApi.Types.PaymentStatusResponse do
  @moduledoc """
  PaymentMethods response struct.
  """
  alias BoldApi.Types.Tax

  @type status :: :active | :processing | :paid | :rejected | :cancelled | :expired

  @type t :: %__MODULE__{
          api_version: String.t(),
          id: String.t(),
          total: float(),
          subtotal: float(),
          tip_amount: float(),
          taxes: list(Tax.t()),
          status: status(),
          expiration_date: integer(),
          creation_date: integer(),
          description: String.t(),
          payment_method: String.t(),
          transaction_id: String.t(),
          amount_type: :open | :close,
          is_sandbox: boolean()
        }

  @enforce_keys []
  defstruct [
    :api_version,
    :id,
    :total,
    :subtotal,
    :tip_amount,
    :taxes,
    :status,
    :expiration_date,
    :creation_date,
    :description,
    :payment_method,
    :transaction_id,
    :amount_type,
    :is_sandbox
  ]
end
