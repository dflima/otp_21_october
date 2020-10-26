defmodule Doit do
  @moduledoc """
  Documentation for `Doit`.
  """

  alias Doit.Boundary.Server

  def add_todo_list_for(username),
    do: DynamicSupervisor.start_child(Doit.DynamicSupervisor, {Server, username})
end
