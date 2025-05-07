defmodule Bold.Types.PaymentLinkResponse do
  @moduledoc """
  PaymentLink response struct.
  """

  @type t :: %__MODULE__{
          payment_link: String.t(),
          url: String.t()
        }

  @enforce_keys []
  defstruct [:payment_link, :url]
end
