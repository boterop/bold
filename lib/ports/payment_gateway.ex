defmodule BoldApi.Ports.PaymentGateway do
  alias BoldApi.Types.{
    PaymentLinkRequest,
    PaymentLinkResponse,
    PaymentMethodsResponse,
    PaymentStatusResponse
  }

  @callback create_link(PaymentLinkRequest.t()) :: PaymentLinkResponse.t()
  @callback get_link(String.t()) :: PaymentStatusResponse.t()
  @callback list_methods() :: PaymentMethodsResponse.t()
end
