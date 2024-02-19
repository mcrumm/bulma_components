defmodule Storybook.CoreComponents.Table do
  use PhoenixStorybook.Story, :component

  def function, do: &StorybookWeb.Components.Table.table/1

  @rows [
    %{first_name: "Jean", last_name: "Dupont", city: "Paris"},
    %{first_name: "Sam", last_name: "Smith", city: "NY", selected: true},
    %{first_name: "John", last_name: "Doe", city: "London"},
    %{first_name: "Jane", last_name: "Doe", city: "Rome"}
  ]
  @slots [
    """
    <:col :let={user} label="First name">
      <%= user.first_name %>
    </:col>
    """,
    """
    <:col :let={user} label="Last name">
      <%= user.last_name %>
    </:col>
    """,
    """
    <:col :let={user} label="City">
      <%= user.city %>
    </:col>
    """
  ]

  def variations do
    List.flatten([
      sample(),
      modifiers(),
      all_mods()
    ])
  end

  def sample() do
    [
      %Variation{
        id: :default,
        description: "Default",
        attributes: %{rows: @rows},
        slots: @slots
      }
    ]
  end

  @modifiers ~w[bordered striped narrow hoverable fullwidth]a

  def modifiers do
    Enum.map(@modifiers, fn modifier ->
      %Variation{
        id: :"table_#{modifier}",
        description: Phoenix.Naming.humanize(modifier),
        attributes:
          %{
            rows: @rows
          }
          |> add_modifier(modifier),
        slots: @slots
      }
    end)
  end

  def all_mods do
    [
      %Variation{
        id: :all_mods,
        description: "All modifiers",
        attributes: %{
          rows: @rows,
          bordered: true,
          striped: true,
          narrow: true,
          hoverable: true,
          fullwidth: true
        },
        slots: @slots
      }
    ]
  end

  def add_modifier(attrs, modifier) do
    Map.put(attrs, modifier, true)
  end
end
