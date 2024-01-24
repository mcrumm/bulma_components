defmodule Storybook.CoreComponents.Button do
  use PhoenixStorybook.Story, :component

  def function, do: &StorybookWeb.CoreComponents.button/1

  def variations do
    [
      %Variation{id: :default, attributes: %{class: "button"}, slots: ["button"]},
      %Variation{id: :info, attributes: %{class: "button is-info"}, slots: ["info"]},
      %Variation{id: :success, attributes: %{class: "button is-success"}, slots: ["success"]},
      %Variation{id: :warning, attributes: %{class: "button is-warning"}, slots: ["warning"]},
      %Variation{id: :danger, attributes: %{class: "button is-danger"}, slots: ["danger"]},
      %Variation{id: :disabled, attributes: %{class: "button is-disabled"}, slots: ["disabled"]}
    ]
  end
end
