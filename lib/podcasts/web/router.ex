defmodule Podcasts.Web.Router do
  use Podcasts.Web, :router

  @doc """
  General purpose pipeline for HTML requests.
  """
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  @doc """
  Plug pipeline the protects the routes in the scope with authentication. In
  other words, only authenticated users can access the routes in the scope where
  this pipeline is.

  Current authenticated user can be access with `Podcasts.Web.ViewHelpers.current_user/1`.
  """
  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.EnsureAuthenticated, handler: Podcasts.Web.Auth.Token
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Podcasts.Web do
    pipe_through :browser # Use the default browser stack

    get "/*path", PageController, :index
    post "/podcast", PageController, :podcast_information

    get "/login", AuthController, :new
    post "/login", AuthController, :create
    delete "/logout", AuthController, :delete

    resources "/users", UserController, only: [:new, :create]
  end

  scope "/", Podcasts.Web do
    pipe_through [:browser, :browser_auth]

    resources "/feeds", FeedController, only: [:index, :show, :new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  scope "/api", Podcasts.Web do
    pipe_through :api

    post "/login", AuthController, :login

    post "/podcast", PageController, :podcast_information_api
    get "/feeds/:id", FeedApiController, :show
  end
end
