defmodule BulmaComponents.Elements do
  @moduledoc """
  Element components.
  """
  use Phoenix.Component

  @doc """
  Renders a button element.
  """
  # Styles
  attr :outlined, :boolean, default: false
  attr :inverted, :boolean, default: false
  attr :rounded, :boolean, default: false
  # Sizes
  attr :small, :boolean, default: false
  attr :normal, :boolean, default: false
  attr :medium, :boolean, default: false
  attr :large, :boolean, default: false

  @is_attrs [:outlined, :inverted, :rounded, :small, :normal, :medium, :large]
  def button(assigns) do
    class_names =
      for style <- @is_attrs, reduce: ["button"] do
        names -> if assigns[style], do: ["is-#{style}" | names], else: names
      end

    assigns = assign(assigns, :class, Enum.reverse(class_names))

    ~H"""
    <button class={@class}><%= render_slot(@inner_block) %></button>
    """
  end
end
