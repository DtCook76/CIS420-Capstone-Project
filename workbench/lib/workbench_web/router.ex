defmodule WorkbenchWeb.Router do
  use WorkbenchWeb, :router

  import WorkbenchWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {WorkbenchWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WorkbenchWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", WorkbenchWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:workbench, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: WorkbenchWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", WorkbenchWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      root_layout: {WorkbenchWeb.Layouts, :login},
      on_mount: [{WorkbenchWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", WorkbenchWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{WorkbenchWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email

      #Locations
      live "/locations", LocationLive.Index, :index
      live "/locations/new", LocationLive.Index, :new
      live "/locations/:id/edit", LocationLive.Index, :edit

      live "/locations/:id", LocationLive.Show, :show
      live "/locations/:id/show/edit", LocationLive.Show, :edit

      #Containers
      live "/containers", ContainerLive.Index, :index
      live "/containers/new", ContainerLive.Index, :new
      live "/containers/:id/edit", ContainerLive.Index, :edit

      live "/containers/:id", ContainerLive.Show, :show
      live "/containers/:id/show/edit", ContainerLive.Show, :edit

      #Tools
      live "/tools", ToolLive.Index, :index
      live "/tools/new", ToolLive.Index, :new
      live "/tools/:id/edit", ToolLive.Index, :edit

      live "/tools/:id", ToolLive.Show, :show
      live "/tools/:id/show/edit", ToolLive.Show, :edit

      #Supplies
      live "/supplies", SupplyLive.Index, :index
      live "/supplies/new", SupplyLive.Index, :new
      live "/supplies/:id/edit", SupplyLive.Index, :edit

      live "/supplies/:id", SupplyLive.Show, :show
      live "/supplies/:id/show/edit", SupplyLive.Show, :edit

      #Projects
      live "/projects", ProjectLive.Index, :index
      live "/projects/new", ProjectLive.Index, :new
      live "/projects/:id/edit", ProjectLive.Index, :edit

      live "/projects/:id", ProjectLive.Show, :show
      live "/projects/:id/show/edit", ProjectLive.Show, :edit

      #Tags
      live "/tags", TagLive.Index, :index
      live "/tags/new", TagLive.Index, :new
      live "/tags/:id/edit", TagLive.Index, :edit

      live "/tags/:id", TagLive.Show, :show
      live "/tags/:id/show/edit", TagLive.Show, :edit
    end
  end

  scope "/", WorkbenchWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{WorkbenchWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
