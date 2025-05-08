defmodule Bold.Ports.PaymentGateway do
  @moduledoc """
  Behaviour for payment gateways.
  """

  alias Bold.Types.{
    Error,
    PaymentLinkRequest,
    PaymentLinkResponse,
    PaymentMethodsResponse,
    PaymentStatusResponse
  }

  @callback create_link(PaymentLinkRequest.t()) ::
              {:ok, PaymentLinkResponse.t()} | {:errors, list(Error.t())}
  @callback get_link(String.t()) :: {:ok, PaymentStatusResponse.t()} | {:errors, list(Error.t())}
  @callback list_methods() :: {:ok, PaymentMethodsResponse.t()} | {:errors, list(Error.t())}
end
