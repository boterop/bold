defmodule Bold.Types.PaymentMethodsResponse do
  @moduledoc """
  PaymentMethods response struct.
  """

  @type payment_method :: {String.t(), %{min: integer(), max: integer()}}
  @type t :: %__MODULE__{
          list: %{String.t() => payment_method}
        }

  @enforce_keys []
  defstruct [:list]
end
