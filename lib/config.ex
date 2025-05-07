defmodule BoldApi.Config do
  @moduledoc """
  Application configuration.
  """

  @default_api_url "https://integrations.api.bold.co"

  def api_url, do: Application.get_env(:bold, :url, @default_api_url)

  def api_key do
    Application.get_env(:bold, :key) || System.get_env("BOLD_API_KEY") ||
      raise("Missing Bold API key")
  end
end
