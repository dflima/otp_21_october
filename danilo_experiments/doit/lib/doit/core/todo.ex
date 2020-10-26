defmodule Doit.Core.Todo do
  @moduledoc """
  Todo context.
  """

  @derive Jason.Encoder

  defstruct title: nil, completed?: false

  @type t :: %__MODULE__{}

  @spec new(Binary.t()) :: t()
  def new(title), do: %__MODULE__{title: title}

  @spec complete(t()) :: t()
  def complete(todo) do
    %__MODULE__{todo | completed?: true}
  end

  @spec convert(t()) :: {:ok, String.t()}
  def convert(todo), do: Jason.encode(todo)
end
