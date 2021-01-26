defmodule LutisWeb.AuthController do
  use LutisWeb, :controller

  plug Ueberauth

  alias Lutis.Users
  alias Lutis.Users.User

  alias Lutis.Repo

  def callback(conn, _params) do
    with %{assigns: %{ueberauth_auth: auth}} <- conn do
      user_params = %{
        email: auth.info.email,
        oauth_token: auth.credentials.token
      }
      signin(conn, user_params)
    end
  end

  defp signin(conn, user_params) do
    with {:ok, user} <- process_user(user_params) do
      conn
      |> redirect(to: Routes.page_path(conn, :index, email: user.email, token: user.oauth_token))
    end
  end

  defp process_user(user_params) do
    case Repo.get_by(User, email: user_params.email) do
      nil -> Users.create_user(user_params)
      user -> Users.update_token(user, user_params.oauth_token)
    end
  end
end
