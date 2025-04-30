defmodule BoldApi.Types.PaymentMethodsResponse do
  @moduledoc """
  PaymentMethods response struct.
  """

  @type payment_method :: {String.t(), %{min: integer(), max: integer()}}
  @type payload :: %{
          payment_methods: list(payment_method())
        }
  @type errors :: list(String.t())
  @type t :: %__MODULE__{
          payload: payload(),
          errors: errors()
        }

  @enforce_keys []
  defstruct [:payload, :errors]
end
