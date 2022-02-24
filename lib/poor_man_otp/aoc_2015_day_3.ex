defmodule PoorMan.AOC2015.Day3 do
  @moduledoc """
  AOC is the module for advent of code
  """

  @doc """
  Calculates the houses where Santa is delivering
  """
  @spec deliver(String.t()) :: integer()
  def deliver(path) do
    path
    |> String.split("", trim: true)
    |> Enum.reduce([{0, 0}], &run_path/2)
    |> Enum.uniq()
    |> Enum.count()
  end

  defp run_path(h, acc) do
    new_position =
      acc
      |> List.last()
      |> evaluate(h)

    acc ++ [new_position]
  end

  defp evaluate({x, y}, ">"), do: {x + 1, y}
  defp evaluate({x, y}, "<"), do: {x - 1, y}
  defp evaluate({x, y}, "^"), do: {x, y + 1}
  defp evaluate({x, y}, "v"), do: {x, y - 1}
end
