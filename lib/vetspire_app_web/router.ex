defmodule VetspireAppWeb.Router do
  use VetspireAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {VetspireAppWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", VetspireAppWeb do
    pipe_through :browser

    live "/", PageLive, :index

    # Blocks Types
    live "/block-types", BlockTypeLive.Index, :index
    live "/block-types/new", BlockTypeLive.Index, :new
    live "/block-types/:id/edit", BlockTypeLive.Index, :edit

    live "/block-types/:id", BlockTypeLive.Show, :show
    live "/block-types/:id/show/edit", BlockTypeLive.Show, :edit

    # Blocks
    live "/blocks", BlockLive.Index, :index
    live "/blocks/new", BlockLive.Index, :new
    live "/blocks/:id/edit", BlockLive.Index, :edit

    live "/blocks/:id", BlockLive.Show, :show
    live "/blocks/:id/show/edit", BlockLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", VetspireAppWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: VetspireAppWeb.Telemetry
    end
  end
end
