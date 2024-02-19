defmodule BulmaComponents.Icon do
  use Phoenix.Component

  @doc """
  Renders a [FontAwesome Icon](https://fontawesome.com).

  ## Examples

      <.icon name="home" />
      <.icon name="spinner" class="fas fa-spinner fa-pulse" />
  """
  attr :name, :string, required: true
  attr :class, :string, default: nil
  attr :color, :string, default: nil
  attr :size, :atom, default: nil, values: [nil, :small, :normal, :medium, :large]
  attr :title, :string, default: nil
  attr :fixed_width, :boolean, default: false
  attr :bordered, :boolean, default: false
  attr :spin, :boolean, default: false

  def icon(%{title: nil} = assigns) do
    ~H"""
    <span class={icon_classes(assigns)}>
      <i class={["fas", "fa-#{@name}"]}></i>
    </span>
    """
  end

  def icon(%{title: title} = assigns) when title != nil do
    ~H"""
    <span class={["icon-text"] ++ container_size_class(@size)}>
      <span class={icon_classes(assigns)}>
        <i class={["fas", "fa-#{@name}"]}></i>
      </span>
      <span><%= @title %></span>
    </span>
    """
  end

  def icon_classes(assigns) do
    ["icon"] ++
      color_class(assigns.color) ++
      icon_size_class(assigns.size) ++
      fixed_width_class(assigns.fixed_width) ++
      bordered_class(assigns.bordered) ++
      spin_class(assigns.spin)
  end

  def spin_class(false), do: []
  def spin_class(true), do: ["fa-pulse"]
  def bordered_class(false), do: []
  def bordered_class(true), do: ["fa-border"]
  def fixed_width_class(false), do: []
  def fixed_width_class(true), do: ["fa-fw"]
  def color_class(nil), do: []
  def color_class(color), do: ["has-text-#{color}"]
  def icon_size_class(nil), do: ["fa-lg"]
  def icon_size_class(:small), do: []
  def icon_size_class(:normal), do: ["fa-lg"]
  def icon_size_class(:medium), do: ["fa-2x"]
  def icon_size_class(:large), do: ["fa-3x"]
  def container_size_class(nil), do: []
  def container_size_class(size), do: ["is-#{size}"]
end
