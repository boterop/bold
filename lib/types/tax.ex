defmodule Bold.Types.Tax do
  @moduledoc """
  Tax struct.
  """

  @type t :: %__MODULE__{
          type: String.t(),
          base: float(),
          value: float()
        }

  @enforce_keys []
  defstruct [:type, :base, :value]
end
