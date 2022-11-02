defmodule Storybook.Components.Button do
  use PhxLiveStorybook.Story, :component

  def function, do: &BulmaComponents.Elements.button/1

  def variations do
    List.flatten([
      color_variation_groups(),
      size_variation_groups(),
      style_variation_groups(),
      state_variation_groups(),
      icon_variation_groups()
    ])
  end

  defp color_variation_groups do
    [
      %VariationGroup{
        id: :colors_rgb,
        description: "Colors",
        variations:
          for color <- BulmaComponents.rgb() do
            %Variation{
              id: :"btn_#{color}",
              attributes: %{color: color},
              slots: [Phoenix.Naming.humanize(color)]
            }
          end
      },
      %VariationGroup{
        id: :colors_light,
        description: "Colors: Light",
        variations:
          for color <- BulmaComponents.rgb() do
            %Variation{
              id: :"btn_#{color}",
              attributes: %{color: color, light: true},
              slots: [Phoenix.Naming.humanize(color)]
            }
          end
      },
      %VariationGroup{
        id: :colors_monochrome,
        description: "Colors: Monochrome",
        variations:
          for color <- BulmaComponents.monochrome() do
            %Variation{
              id: :"btn_#{color}",
              attributes: %{color: color},
              slots: [Phoenix.Naming.humanize(color)]
            }
          end
      }
    ]
  end

  defp size_variation_groups do
    sizes = [:small, nil, :normal, :medium, :large]

    [
      %VariationGroup{
        id: :sizes,
        variations:
          for size <- sizes do
            %Variation{
              id: :"btn_size_#{size}",
              attributes: if(size, do: %{size: size}, else: %{}),
              slots: [if(size, do: Phoenix.Naming.humanize(size), else: "Default")]
            }
          end
      },
      %VariationGroup{
        id: :responsive_sizes,
        variations:
          for size <- sizes do
            %Variation{
              id: :"btn_size_#{size}_responsize",
              attributes:
                if(size, do: %{size: size, responsive: true}, else: %{responsive: true}),
              slots: [if(size, do: Phoenix.Naming.humanize(size), else: "Default")]
            }
          end
      }
    ]
  end

  defp style_variation_groups do
    groups =
      for style <- [:outlined, :inverted, :rounded] do
        name = Phoenix.Naming.humanize(style)

        %VariationGroup{
          id: :"styles_#{style}",
          description: "Styles: #{name}",
          variations:
            for color <- BulmaComponents.rgb() do
              %Variation{
                id: :"btn_style_#{style}_#{color}",
                attributes: %{style => true, color: color},
                slots: [name]
              }
            end
        }
      end

    groups ++
      [
        %VariationGroup{
          id: :styles_invert_outlined,
          description: "Styles: Invert Outlined",
          variations:
            for color <- BulmaComponents.rgb() do
              %Variation{
                id: :"btn_style_outlined_#{color}",
                attributes: %{inverted: true, outlined: true, color: color},
                slots: ["Invert Outlined"]
              }
            end
        }
      ]
  end

  defp state_variation_groups do
    for state <- [:hovered, :focused, :active, :loading, :disabled] do
      name = Phoenix.Naming.humanize(state)

      %VariationGroup{
        id: :"states_#{state}",
        description: name,
        variations:
          for color <- [nil | BulmaComponents.rgb()] do
            %Variation{
              id: :"btn_state_hover_#{color}",
              attributes: if(color, do: %{state => true, color: color}, else: %{state => true}),
              slots: [name]
            }
          end
      }
    end
  end

  defp icon_variation_groups do
    [
      %VariationGroup{
        id: :icons,
        variations:
          for size <- [:small, nil, :normal, :medium, :large] do
            %Variation{
              id: :"btn_icon_#{size}",
              attributes: if(size, do: %{size: size}, else: %{}),
              slots: [
                """
                <span class="icon is-small">
                  <i class="fa-solid fa-book"></i>
                </span>
                """
              ]
            }
          end
      },
      %VariationGroup{
        id: :icons_spans,
        variations:
          for size <- [:small, nil, :medium, :large] do
            %Variation{
              id: :"btn_icon_#{size}",
              attributes: if(size, do: %{size: size}, else: %{}),
              slots: [
                """
                <span class="icon is-small">
                  <i class="fa-solid fa-book"></i>
                </span>
                <span>Book</span>
                """
              ]
            }
          end
      }
    ]
  end
end
