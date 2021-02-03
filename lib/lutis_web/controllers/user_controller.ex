defmodule LutisWeb.UserController do
  use LutisWeb, :controller

  alias Lutis.Users

  action_fallback LutisWeb.FallbackController

  def username(conn, %{"username" => username, "email" => email}) do
    with {:ok, user} <- Users.add_username(email, username) do
      render(conn, "username.json", user: user)
    end
  end
end
