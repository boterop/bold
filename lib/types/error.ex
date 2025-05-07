defmodule Bold.Types.Error do
  @moduledoc """
  Error struct.
  """

  @type t :: %{String.t() => String.t()} | atom() | String.t()
end
