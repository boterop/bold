defmodule Bold do
  @moduledoc """
  Bold API client.
  """

  alias Bold.Adapters.PaymentGateway

  @adapter Application.compile_env(:bold, :adapter, PaymentGateway)

  defdelegate create_link(params), to: @adapter
  defdelegate get_link(id), to: @adapter
  defdelegate list_methods(), to: @adapter
end
