defmodule LutisWeb.UserView do
  use LutisWeb, :view

  def render("username.json", %{user: user}) do
    %{data: %{username: user.username}}
  end
end
