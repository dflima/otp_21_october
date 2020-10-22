defmodule Mindex.Boundary.Server do
  @moduledoc false

  use GenServer
  alias __MODULE__
  alias Mindex.Core.Board

  # APIs
  @spec start_link(Board.t()) :: {:ok, pid()}
  def start_link(board), do: GenServer.start_link(Server, board, name: Server)

  @spec move(List.t()) :: Board.t()
  def move(guess), do: GenServer.call(Server, {:move, guess})

  @spec boom() :: any()
  def boom, do: GenServer.cast(Server, :boom)

  # Callbacks
  @impl true
  def init(_board), do: {:ok, Board.new()}

  @impl true
  def handle_call({:move, guess}, _from, board) do
    new_board = Board.move(board, guess)
    {:reply, Board.to_string(new_board), new_board}
  end

  @impl true
  def handle_cast(:boom, _board), do: raise("Boom! 💣")
end
