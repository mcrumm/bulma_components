defmodule StorybookWeb.Storybook do
  use PhoenixStorybook,
    otp_app: :storybook_web,
    content_path: Path.expand("../../storybook", __DIR__),
    # assets path are remote path, not local file-system paths
    css_path: "/assets/storybook.css",
    js_path: "/assets/storybook.js",
    sandbox_class: "bulma-components-sandbox",
    font_awesome_plan: :free,
    font_awesome_kit_id: "a86d7ff2ff",
    font_awesome_rendering: :webfont
end
