defmodule Storybook.Components.Elements.Button do
  use PhxLiveStorybook.Story, :component

  def function, do: &BulmaComponents.Elements.button/1

  def variations do
    [
      %Variation{
        id: :default,
        template: "<.button>Press me</.button>"
      },
      %Variation{
        id: :outlined,
        template: "<.button outlined>Press me</.button>"
      },
      %Variation{
        id: :inverted,
        template: "<.button inverted>Press me</.button>"
      },
      %Variation{
        id: :outlined_inverted,
        template: "<.button outlined inverted>Press me</.button>"
      },
      %Variation{
        id: :rounded,
        template: "<.button rounded>Press me</.button>"
      },
    ]
  end
end
