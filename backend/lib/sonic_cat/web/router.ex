defmodule SonicCat.Web.Router do
  use SonicCat.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.EnsureAuthenticated, handler: SonicCat.Web.Auth.Token
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "User"
    plug Guardian.Plug.EnsureAuthenticated, handler: SonicCat.Web.Auth.Token
    plug Guardian.Plug.LoadResource
  end

  scope "/", SonicCat.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", SonicCat.Web do
    pipe_through :api

    post "/login", AuthController, :login
    post "/register", AuthController, :register
  end
end
