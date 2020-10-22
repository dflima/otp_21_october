defmodule Mindex.Core.Score do
  @moduledoc false

  @red "R"
  @white "W"
  @blank "-"
  @max_length 4

  defstruct red: 0, white: 0

  @type t :: %__MODULE__{}

  # add guard to ensure guess and answer have 4 integers each (in the range of 1..8)
  def new(guess \\ [1, 3, 5, 8], answer \\ [1, 2, 3, 4]),
    do: %__MODULE__{red: count_red(guess, answer), white: count_white(guess, answer)}

  def render_string(%{red: red, white: white}) do
    @red
    |> String.duplicate(red)
    |> Kernel.<>(String.duplicate(@white, white))
    |> Kernel.<>(String.duplicate(@blank, @max_length - red - white))
  end

  defp count_red(guess, answer) do
    guess
    |> Enum.zip(answer)
    |> Enum.count(fn {x, y} -> x == y end)
  end

  defp count_white(guess, answer) do
    size_count = Enum.count(answer)
    miss_count = Enum.count(guess -- answer)
    red_count = count_red(guess, answer)

    size_count - red_count - miss_count
  end
end
