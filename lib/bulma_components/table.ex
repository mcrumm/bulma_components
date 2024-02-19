defmodule BulmaComponents.Table do
  use Phoenix.Component

  attr :rows, :list, doc: "Data you want to list", required: true
  attr :bordered, :boolean, default: false
  attr :striped, :boolean, default: false
  attr :narrow, :boolean, default: false
  attr :hoverable, :boolean, default: false
  attr :fullwidth, :boolean, default: false

  slot :col, doc: "Describe one of your table columns" do
    attr :label, :string, doc: "Column label", required: true
  end

  @doc """
  Simple table component.

  """
  def table(assigns) do
    ~H"""
    <table class={modifier_classes(assigns) ++ ["table"]}>
      <thead>
        <tr>
          <th :for={col <- @col}><%= col.label %></th>
        </tr>
      </thead>
      <tbody>
        <tr :for={row <- @rows} class={selected_class(row)}>
          <td :for={col <- @col}>
            <%= render_slot(col, row) %>
          </td>
        </tr>
      </tbody>
    </table>
    """
  end

  def modifier_classes(assigns) do
    Enum.filter([:bordered, :striped, :narrow, :hoverable, :fullwidth], fn key -> assigns[key] end)
    |> Enum.map(fn key -> "is-#{key}" end)
  end

  def selected_class(row) do
    if row[:selected], do: "is-selected", else: ""
  end
end
