defmodule Storybook.CoreComponents.Input do
  use PhoenixStorybook.Story, :component
  alias BulmaComponents.{Form, Input}

  def function, do: &Input.input/1
  def imports, do: [{Form, [simple_form: 1]}]

  def template do
    """
    <.simple_form :let={f} for={%{}} as={:story} class="w-full">
      <.psb-variation-group field={f[:field]}/>
    </.simple_form>
    """
  end

  @attrs [
    [
      :text,
      %{
        color: "primary",
        icon: "font",
        icon_color: "success",
        icon_size: :small,
        icon_align: :left,
        errors: ["This is an error message"]
      }
    ],
    [
      :text,
      %{
        color: "primary",
        icon: "font",
        icon_color: "success",
        icon_size: :small,
        icon_align: :left
      }
    ]

    # [:password, %{icon: "lock"}],
    # [:email, %{value: "fred@example.com", icon: "check", color: "link"}],
    # [:textarea, %{icon: "envelope", color: "info", rows: 4}],
    # [:number, %{}],
    # [:date, %{icon: "calendar"}],
    # [:color, %{icon: "paintbrush"}],
    # [:checkbox, %{}],
    # [
    #   :select,
    #   %{
    #     icon: "globe",
    #     options: ["Option 1", "Option 2", "Option 3"]
    #   }
    # ],
    # [:file, %{icon: "upload"}],
    # [:radio, %{icon: "check"}],
    # [:range, %{icon: "sliders"}],
    # [:search, %{icon: "search"}],
    # [:tel, %{icon: "phone"}],
    # [:url, %{icon: "link"}],
    # [:datetime, %{icon: "calendar"}]
  ]

  def story_vars do
    for [type, type_attrs] <- @attrs do
      attrs =
        %{
          type: to_string(type),
          label: String.capitalize("#{type}")
        }
        |> Map.merge(type_attrs)

      id =
        "#{type}_#{UUID.uuid4()}"
        |> String.to_atom()

      %Variation{
        id: id,
        attributes: attrs
      }
    end
  end

  def variations do
    [
      %VariationGroup{
        id: :basic_inputs,
        variations: story_vars()
      }
    ]
  end
end
