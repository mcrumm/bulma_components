defmodule Storybook.CoreComponents.Modal do
  use PhoenixStorybook.Story, :component

  def function, do: &BulmaComponents.Modal.modal/1

  def imports,
    do: [
      {BulmaComponents.Button, [button: 1]},
      {BulmaComponents.Modal, [hide_modal: 1, show_modal: 1]}
    ]

  def template do
    """
    <.psb-variation/>
      <.button phx-click={show_modal(":variation_id")} psb-code-hidden>
      Open modal
    </.button>
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        slots: [
          """
          <div class='block'>
            Modal body
          </div>
          """
        ]
      }
    ]
  end
end
