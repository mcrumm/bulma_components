defmodule BulmaComponentsStorybookWeb.Storybook do
  use PhoenixStorybook,
    otp_app: :bulma_components_storybook_web,
    content_path: Path.expand("../../storybook", __DIR__),
    # assets path are remote path, not local file-system paths
    css_path: "/assets/storybook.css",
    js_path: "/assets/storybook.js",
    sandbox_class: "bulma-components-storybook-web"
end
