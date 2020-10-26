defmodule Doit.Boundary.Server do
  @moduledoc """
  Doit GenServer.
  """
  use GenServer
  alias Doit.Core.Todo

  # APIs

  def start_link(username), do: GenServer.start_link(__MODULE__, [], name: username)

  def add(todo_list \\ __MODULE__, todo), do: GenServer.call(todo_list, {:add, todo})

  # def complete(todo_list \\ __MODULE__, todo), do: GenServer.call(todo_list, {:complete, todo})

  # Callbacks

  def init(initial), do: {:ok, initial}

  def handle_call({:add, todo}, _from, todo_list) do
    new_list = [Todo.new(todo) | todo_list]

    json_list =
      Enum.map(new_list, fn todo ->
        {:ok, converted} = Todo.convert(todo)
        converted
      end)

    {:reply, json_list, new_list}
  end

  def child_spec(username), do: %{id: username, start: {__MODULE__, :start_link, [username]}}
end
