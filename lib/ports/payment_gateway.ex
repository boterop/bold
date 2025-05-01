defmodule BoldApi.Ports.PaymentGateway do
  alias BoldApi.Types.{
    Error,
    PaymentLinkRequest,
    PaymentLinkResponse,
    PaymentMethodsResponse,
    PaymentStatusResponse
  }

  @callback create_link(PaymentLinkRequest.t()) ::
              {:ok, PaymentLinkResponse.t()} | {:errors, Error.t()}
  @callback get_link(String.t()) :: {:ok, PaymentStatusResponse.t()} | {:errors, Error.t()}
  @callback list_methods() :: {:ok, PaymentMethodsResponse.t()} | {:errors, Error.t()}
end
