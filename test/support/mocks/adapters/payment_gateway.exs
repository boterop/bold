defmodule BoldApi.Mocks.Adapters.PaymentGateway do
  @moduledoc """
  Mock payment gateway adapter.
  """

  alias BoldApi.Config

  alias BoldApi.Types.{
    PaymentLinkRequest,
    PaymentLinkResponse,
    PaymentMethodsResponse,
    PaymentStatusResponse
  }

  @behaviour BoldApi.Ports.PaymentGateway

  @id "LNK_3N09Z1EP0Y"

  @impl true
  def create_link(%PaymentLinkRequest{}) do
    Config.api_key()

    {:ok,
     %PaymentLinkResponse{
       payment_link: @id,
       url: "https://checkout.bold.co/payment/#{@id}"
     }}
  end

  def create_link(_), do: {:errors, [%{"code" => "PL_000", "errors" => "Invalid params"}]}

  @impl true
  def get_link(id) do
    case id do
      @id -> {:ok, %PaymentStatusResponse{id: @id}}
      _ -> {:errors, [%{"code" => "PL_000", "errors" => "Link #{id} not valid"}]}
    end
  end

  @impl true
  def list_methods() do
    {:ok,
     %PaymentMethodsResponse{
       list: %{"PSE" => %{"max" => 10_000_000, "min" => 1000}}
     }}
  end
end
