defmodule Bold.Adapters.PaymentGateway do
  @moduledoc """
  HTTP client to communicate with the Bold API.
  """

  use Tesla

  alias Bold.Config

  alias Bold.Types.{
    Error,
    PaymentLinkRequest,
    PaymentLinkResponse,
    PaymentMethodsResponse,
    PaymentStatusResponse
  }

  @behaviour Bold.Ports.PaymentGateway

  plug(Tesla.Middleware.BaseUrl, Config.api_url())

  plug(Tesla.Middleware.Headers, [
    {"Content-Type", "application/json"},
    {"Authorization", "x-api-key #{Config.api_key()}"}
  ])

  plug(Tesla.Middleware.JSON)

  @url "/online/link/v1"

  @impl true
  @spec create_link(PaymentLinkRequest.t()) ::
          {:ok, PaymentLinkResponse.t()} | {:errors, list(Error.t())}
  def create_link(params) when is_map(params) do
    @url
    |> post(link_request(params))
    |> link_response()
  end

  @impl true
  @spec get_link(String.t()) :: {:ok, PaymentStatusResponse.t()} | {:errors, list(Error.t())}
  def get_link(id) when is_binary(id) do
    "#{@url}/#{id}"
    |> get()
    |> status_response()
  end

  @impl true
  @spec list_methods() :: {:ok, PaymentMethodsResponse.t()} | {:errors, list(Error.t())}
  def list_methods do
    "#{@url}/payment_methods"
    |> get()
    |> methods_response()
  end

  @spec link_request(PaymentLinkRequest.t()) :: map()
  defp link_request(%PaymentLinkRequest{} = request) do
    amount_type = Map.get(request, :amount_type)
    amount = Map.get(request, :amount)
    description = Map.get(request, :description)
    expiration_date = Map.get(request, :expiration_date)
    callback_url = Map.get(request, :callback_url)
    payment_methods = Map.get(request, :payment_methods)
    payer_email = Map.get(request, :payer_email)
    image_url = Map.get(request, :image_url)

    amount_type =
      case amount_type do
        :close -> "CLOSE"
        _ -> "OPEN"
      end

    %{
      amount_type: amount_type,
      amount: amount,
      description: description,
      expiration_date: expiration_date,
      callback_url: callback_url,
      payment_methods: payment_methods,
      payer_email: payer_email,
      image_url: image_url
    }
  end

  defp link_request(_), do: %{}

  @spec link_response({:ok, Tesla.Env.t()}) ::
          {:ok, PaymentLinkResponse.t()} | {:errors, list(Error.t())}
  defp link_response({:ok, %Tesla.Env{status: 200, body: %{"payload" => body}}}) do
    link = %PaymentLinkResponse{payment_link: body["payment_link"], url: body["url"]}

    {:ok, link}
  end

  defp link_response({:ok, %Tesla.Env{status: _code, body: %{"errors" => errors}}}) do
    {:errors, errors}
  end

  defp link_response({:ok, %Tesla.Env{status: _code, body: reason}}) do
    {:errors, [reason]}
  end

  defp link_response({:error, reason}) do
    {:errors, reason}
  end

  @spec status_response({:ok, Tesla.Env.t()} | {:error, Tesla.Env.t()}) ::
          {:ok, PaymentStatusResponse.t()} | {:error, list(Error.t())}
  defp status_response({:ok, %Tesla.Env{status: 200, body: body}}) do
    amount_type =
      case body["amount_type"] do
        "OPEN" -> :open
        _ -> :close
      end

    status =
      case body["status"] do
        "ACTIVE" -> :active
        "PROCESSING" -> :processing
        "PAID" -> :paid
        "REJECTED" -> :rejected
        "CANCELLED" -> :cancelled
        "EXPIRED" -> :expired
      end

    status = %PaymentStatusResponse{
      api_version: body["api_version"],
      id: body["id"],
      total: body["total"],
      subtotal: body["subtotal"],
      tip_amount: body["tip_amount"],
      taxes: body["taxes"],
      status: status,
      expiration_date: body["expiration_date"],
      creation_date: body["creation_date"],
      description: body["description"],
      payment_method: body["payment_method"],
      transaction_id: body["transaction_id"],
      amount_type: amount_type,
      is_sandbox: body["is_sandbox"]
    }

    {:ok, status}
  end

  defp status_response({:ok, %Tesla.Env{status: _code, body: %{"errors" => errors}}}) do
    {:errors, errors}
  end

  defp status_response({:error, reason}) do
    {:errors, [reason]}
  end

  @spec methods_response({:ok, Tesla.Env.t()} | {:error, Tesla.Env.t()}) ::
          {:ok, PaymentMethodsResponse.t()} | {:error, list(Error.t())}
  defp methods_response({:ok, %Tesla.Env{status: 200, body: %{"payload" => body}}}) do
    methods = %PaymentMethodsResponse{
      list: body["payment_methods"]
    }

    {:ok, methods}
  end

  defp methods_response({:ok, %Tesla.Env{status: _code, body: %{"errors" => errors}}}) do
    {:errors, errors}
  end

  defp methods_response({:ok, _}) do
    {:errors, [:request_failed]}
  end

  defp methods_response({:error, reason}) do
    {:errors, [reason]}
  end
end
