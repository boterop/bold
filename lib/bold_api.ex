defmodule BoldApi do
  @moduledoc """
  Bold API client.
  """

  alias BoldApi.Adapters.PaymentGateway

  @adapter Application.compile_env(:bold_api, :adapter, PaymentGateway)

  defdelegate create_link(params), to: @adapter
  defdelegate get_link(id), to: @adapter
  defdelegate list_methods(), to: @adapter
end
