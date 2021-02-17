defmodule LutisWeb.Router do
  use LutisWeb, :router

  alias Ueberauth.Strategy.Google.OAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth_api do
    plug :accepts, ["json"]
    plug :authenticate
  end

  scope "/", LutisWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", LutisWeb do
    pipe_through :auth_api

    post "/username", UserController, :username
  end

  scope "/auth", LutisWeb do
    pipe_through :browser

    get "/google", AuthController, :request
    get "/google/callback", AuthController, :callback
  end

  defp authenticate(conn, _params) do
    case verify_token(conn) do
      {:ok, conn} ->
        conn
      {:error, :unauthorized} ->
        conn
        |> put_view(LutisWeb.ErrorView)
        |> render("error.json", error: %{access: ["unauthorized"]})
        |> halt()
    end
  end

  defp verify_token(conn) do
    email = conn.params["email"]
    case OAuth.get(conn.params["token"], "https://www.googleapis.com/oauth2/v1/userinfo?alt=json") do
      {:ok, %OAuth2.Response{body: %{"email" => ^email}}} ->
        {:ok, conn}
      _ ->
        {:error, :unauthorized}
    end
  end
  #coveralls-ignore-start

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
      live_dashboard "/dashboard", metrics: LutisWeb.Telemetry
    end
  end

  #coveralls-ignore-stop
end
