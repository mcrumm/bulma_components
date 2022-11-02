defmodule BulmaComponents do
  @moduledoc """
  Documentation for `BulmaComponents`.
  """

  @rgb [
    :primary,
    :link,
    :info,
    :success,
    :warning,
    :danger
  ]

  @monochrome [
    :white,
    :light,
    :dark,
    :black,
    :text,
    :ghost
  ]

  @colors @rgb ++ @monochrome

  @doc """
  Returns a list of Bulma `$colors` as atoms.

  ## Examples

      iex> BulmaComponents.colors()
      #{inspect(@colors)}
  """
  def colors, do: @colors

  @doc """
  Returns a list of monochrome colors as atoms.

  ## Examples

      iex> BulmaComponents.monochrome()
      #{inspect(@monochrome)}
  """
  def monochrome, do: @monochrome

  @doc """
  Returns a list of rgb colors as atoms.

  ## Examples

      iex> BulmaComponents.rgb()
      #{inspect(@rgb)}
  """
  def rgb, do: @rgb
end
