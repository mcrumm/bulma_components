defmodule Storybook.Components.Icon do
  use PhoenixStorybook.Story, :component
  alias BulmaComponents.{Colors, Icon}

  def function, do: &Icon.icon/1

  @icons ~w(
    bars
    book
    calendar
    check
    close
    download
    edit
    ellipsis
    envelope
    external-link
    file
    filter
    folder
    gear
    home
    image
    info
    link
    list
    lock
    phone
    plus
    search
    share
    star
    trash
    upload
    user
  )

  def variations do
    List.flatten([
      style_variation_groups(),
      size_variation_groups(),
      color_variation_groups(),
      icon_variation_groups()
    ])
  end

  defp style_variation_groups do
    icons_for_style = [
      [:bordered, "house"],
      [:fixed_width, "house"],
      [:spin, "spinner"],
      [:spin, "circle-notch"]
    ]

    [
      %VariationGroup{
        id: :styles_invert_outlined,
        description: "Variations",
        variations:
          for [style, icon] <- icons_for_style do
            %Variation{
              id: :"btn_style_bordered_#{style}_#{icon}",
              attributes: %{
                style => true,
                name: icon,
                title: Phoenix.Naming.humanize(style)
              }
            }
          end
      }
    ]
  end

  defp color_variation_groups do
    [
      %VariationGroup{
        id: :colors,
        description: "Colors",
        variations:
          for color <- Colors.rgb() do
            %Variation{
              id: :"icon_#{color}",
              attributes: %{
                color: color,
                name: "book",
                title: Phoenix.Naming.humanize(color)
              }
            }
          end
      }
    ]
  end

  defp size_variation_groups do
    [
      %VariationGroup{
        id: :sizes,
        description: "Sizes",
        variations:
          for size <- [:small, nil, :medium, :large] do
            %Variation{
              id: :"icon_size_#{size}",
              attributes: %{
                name: "book",
                size: size,
                title: Phoenix.Naming.humanize(size)
              }
            }
          end
      }
    ]
  end

  defp icon_variation_groups do
    [
      %VariationGroup{
        id: :colors,
        description: "Icons",
        variations:
          for icon <- @icons do
            %Variation{
              id: :"icon_type_#{icon}",
              attributes: %{
                name: icon,
                title: Phoenix.Naming.humanize(icon)
              }
            }
          end
      }
    ]
  end
end
