defmodule BoldApi.Types.PaymentLinkResponse do
  @moduledoc """
  PaymentLink response struct.
  """

  @type payload :: %{
          payment_link: String.t(),
          url: String.t()
        }

  @type errors :: list(String.t())

  @type t :: %__MODULE__{
          payload: payload(),
          errors: errors()
        }

  @enforce_keys [:payload, :errors]
  defstruct [:payload, :errors]
end
