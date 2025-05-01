defmodule BoldApi.Types.Error do
  @moduledoc """
  Error struct.
  """

  @type t :: list(%{String.t() => String.t()}) | list(atom()) | list(String.t())
end
