defmodule BoldApiTest do
  use ExUnit.Case

  alias BoldApi.Types.{PaymentLinkRequest, PaymentLinkResponse}

  setup do
    Application.put_env(:bold, :key, nil)
  end

  test "api key error" do
    assert_raise RuntimeError, fn ->
      %PaymentLinkRequest{amount_type: :open} |> BoldApi.create_link()
    end
  end

  describe "mocked adapter" do
    setup do
      Application.put_env(:bold, :key, "secret")
    end

    test "create link" do
      {:ok, %PaymentLinkResponse{}} =
        %PaymentLinkRequest{amount_type: :open} |> BoldApi.create_link()
    end
  end
end
