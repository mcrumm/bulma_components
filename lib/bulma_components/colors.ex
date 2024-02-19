defmodule BulmaComponents.Colors do
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

      iex> CoreComponents.colors()
      #{inspect(@colors)}
  """
  def colors, do: @colors

  @doc """
  Returns a list of monochrome colors as atoms.

  ## Examples

      iex> CoreComponents.monochrome()
      #{inspect(@monochrome)}
  """
  def monochrome, do: @monochrome

  @doc """
  Returns a list of rgb colors as atoms.

  ## Examples

      iex> CoreComponents.rgb()
      #{inspect(@rgb)}
  """
  def rgb, do: @rgb
end
