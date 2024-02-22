defmodule BulmaComponents.Input do
  @moduledoc """
  Input components.
  """
  use Phoenix.Component
  alias Phoenix.HTML.{Form, FormField}

  import BulmaComponents.Icon

  @doc """
  Renders an input with label and error messages.

  A `FormField` may be passed as argument,
  which is used to retrieve the input name, id, and values.
  Otherwise all attributes may be passed explicitly.

  ## Types

  This function accepts all HTML input types, considering that:

    * You may also set `type="select"` to render a `<select>` tag

    * `type="checkbox"` is used exclusively to render boolean values

    * For live file uploads, see `Phoenix.Component.live_file_input/1`

  See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input
  for more information.

  ## Examples

      <.input field={@form[:email]} type="email" />
      <.input name="my-input" errors={["oh no!"]} />
  """
  attr :id, :any, default: nil
  attr :name, :any
  attr :label, :string, default: nil
  attr :value, :any

  attr :type, :string,
    default: "text",
    values: ~w(checkbox color date datetime-local email file hidden month number password
               range radio search select tel text textarea time url week)

  attr :field, FormField,
    doc: "a form field struct retrieved from the form, for example: @form[:email]"

  attr :errors, :list, default: []
  attr :checked, :boolean, doc: "the checked flag for checkbox inputs"
  attr :prompt, :string, default: nil, doc: "the prompt for select inputs"
  attr :options, :list, doc: "the options to pass to Form.options_for_select/2"
  attr :multiple, :boolean, default: false, doc: "the multiple flag for select inputs"
  attr :icon, :string, default: nil, doc: "the icon to render next to the input"
  attr :icon_align, :atom, default: :left, values: [:left, :right], doc: "the icon alignment"
  attr :icon_color, :string, default: nil, doc: "the color of the icon"

  attr :icon_size, :atom,
    default: nil,
    values: [:small, nil, :medium, :large],
    doc: "the icon size"

  attr :color, :string, default: nil, doc: "the color of the input"

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)

  slot :inner_block

  def input(%{field: %FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign(:errors, Enum.map(field.errors, &translate_error(&1)))
    |> assign_new(:name, fn -> if assigns.multiple, do: field.name <> "[]", else: field.name end)
    |> assign_new(:value, fn -> field.value end)
    |> input()
  end

  def input(%{type: "checkbox"} = assigns) do
    assigns =
      assign_new(assigns, :checked, fn ->
        Form.normalize_value("checkbox", assigns[:value])
      end)

    ~H"""
    <div phx-feedback-for={@name} class="field">
      <div class="control">
        <label class="checkbox">
          <input type="hidden" name={@name} value="false" />
          <input
            type="checkbox"
            class="checkbox"
            id={@id}
            name={@name}
            value="true"
            checked={@checked}
            {@rest}
          />
          <%= @label %>
        </label>

        <.icon :if={@icon} name={@icon} size={@icon_size} align={@icon_align} color={@icon_color} />
        <.error_icon errors={@errors} />
      </div>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  def input(%{type: "select"} = assigns) do
    ~H"""
    <div phx-feedback-for={@name} class="field">
      <.label for={@id}><%= @label %></.label>

      <div class={control_classes(assigns)}>
        <div class="select">
          <select id={@id} name={@name} class="select" multiple={@multiple} {@rest}>
            <option :if={@prompt} value=""><%= @prompt %></option>
            <%= Form.options_for_select(@options, @value) %>
          </select>
        </div>

        <.icon :if={@icon} name={@icon} size={@icon_size} align={@icon_align} color={@icon_color} />
        <.error_icon errors={@errors} />
      </div>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  def input(%{type: "textarea"} = assigns) do
    ~H"""
    <div class="field" phx-feedback-for={@name}>
      <div class={control_classes(assigns)}>
        <.label for={@id}><%= @label %></.label>
        <textarea id={@id} name={@name} class={input_classes(assigns)} {@rest}>
          <%= Form.normalize_value("textarea", @value) %>
        </textarea>

        <.icon :if={@icon} name={@icon} size={@icon_size} align={@icon_align} color={@icon_color} />
        <.error_icon errors={@errors} />
      </div>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  # All other inputs text, datetime-local, url, password, etc. are handled here...
  def input(assigns) do
    ~H"""
    <div class="field" phx-feedback-for={@name}>
      <.label for={@id}><%= @label %></.label>
      <div class={control_classes(assigns)}>
        <input
          type={@type}
          name={@name}
          id={@id}
          value={Form.normalize_value(@type, @value)}
          class={input_classes(assigns)}
          {@rest}
        />

        <.icon :if={@icon} name={@icon} size={@icon_size} align={@icon_align} color={@icon_color} />
        <.icon :if={@errors != []} name="exclamation-triangle" align={:right} color="danger" />
      </div>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  @doc """
  Renders a label.
  """
  attr :for, :string, default: nil
  slot :inner_block, required: true

  def label(assigns) do
    ~H"""
    <label for={@for} class="label">
      <%= render_slot(@inner_block) %>
    </label>
    """
  end

  @doc """
  Generates a generic error message.
  """
  slot :inner_block, required: true

  def error(assigns) do
    ~H"""
    <p class="help phx-no-feedback:hidden">
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

  def error_icon(assigns) do
    ~H"""
    <.icon name="exclamation-triangle" size={:small} align={:right} class="phx-no-feedback:hidden" />
    """
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # However the error messages in our forms and APIs are generated
    # dynamically, so we need to translate them by calling Gettext
    # with our gettext backend as first argument. Translations are
    # available in the errors.po file (as we use the "errors" domain).
    if count = opts[:count] do
      Gettext.dngettext(StorybookWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(StorybookWeb.Gettext, "errors", msg, opts)
    end
  end

  @doc """
  Translates the errors for a field from a keyword list of errors.
  """
  def translate_errors(errors, field) when is_list(errors) do
    for {^field, {msg, opts}} <- errors, do: translate_error({msg, opts})
  end

  defp input_classes(assigns) do
    ["input"] ++
      error_classes(assigns.errors) ++
      icon_classes(assigns.icon, assigns.icon_align)
  end

  defp control_classes(assigns) do
    ["control"] ++
      control_icon_classes(assigns.icon, assigns.errors, assigns.icon_align)
  end

  defp control_icon_classes(nil, _, _), do: ["has-icons-right"]
  defp control_icon_classes(_, _, :left), do: ["has-icons-left", "has-icons-right"]
  defp control_icon_classes(_, _, :right), do: ["has-icons-right"]

  defp error_classes([]), do: []
  defp error_classes(_), do: ["is-danger"]

  defp icon_classes(nil, _), do: []
  defp icon_classes(_, :left), do: ["is-left"]
  defp icon_classes(_, :right), do: ["is-right"]
end
