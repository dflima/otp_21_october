defmodule Doit.Core.TodoList do
  @moduledoc """
  TodoList context.
  """

  defstruct list: []

  @type t() :: %__MODULE__{}

  @spec new() :: t()
  def new, do: %__MODULE__{}

  @spec new(Todo.t() | List.t()) :: t()
  def new(list) when is_list(list), do: %__MODULE__{list: list}
  def new(todo), do: new([todo])

  @spec add(t(), Todo.t()) :: t()
  def add(list, todo), do: %__MODULE__{list | list: [todo | list.list]}
end
