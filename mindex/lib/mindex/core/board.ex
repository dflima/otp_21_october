defmodule Mindex.Core.Board do
  @moduledoc false

  alias Mindex.Core.Score

  defstruct answer: [], guesses: [], won: false, lost: false

  @type t :: %__MODULE__{}

  @spec new() :: t()
  def new, do: new(random_answer())

  @spec new(List.t()) :: t()
  def new([_, _, _, _] = answer), do: %__MODULE__{answer: answer}

  @spec random_answer() :: List.t()
  def random_answer, do: 1..8 |> Enum.shuffle() |> Enum.take(4)

  @spec move(t(), List.t()) :: t()
  def move(board, guess), do: %{board | guesses: [guess | board.guesses]}

  @spec to_string(t()) :: String.t()
  def to_string(board), do: board |> put_status() |> print()

  @spec won?(t()) :: boolean()
  def won?(%{guesses: [answer | _guesses], answer: answer}), do: true

  def won?(_board), do: false

  @spec lost?(t()) :: boolean()
  def lost?(board), do: not won?(board) and length(board.guesses) == 10

  defp put_status(%{answer: answer, guesses: guesses} = board),
    do: %{board | won: won?(board), lost: lost?(board), guesses: rows(guesses, answer)}

  defp rows(guesses, answer), do: guesses |> Enum.map(&row(&1, answer))

  defp row(guess, answer), do: %{guess: guess, score: Score.new(guess, answer)}

  defp print(%{guesses: rows}), do: rows |> Enum.map(&print_row/1)

  defp print_row(%{guess: guess, score: score}) do
    print_guess(guess)
    Score.render_string(score)
  end

  defp print_guess([a, b, c, d]) do
    IO.inspect("Guess: #{a}, #{b}, #{c}, #{d}")
  end
end
