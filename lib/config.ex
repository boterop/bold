defmodule BoldApi.Config do
  @moduledoc """
  Application configuration.
  """

  @default_api_url "https://integrations.api.bold.co"

  def api_url, do: Application.get_env(:bold_api, :url, @default_api_url)
  def api_key, do: Application.get_env(:bold_api, :key) || raise("Missing Bold API key")
end
