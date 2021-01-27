defmodule Lutis.UsersTest do
  use Lutis.DataCase

  alias Lutis.Users

  describe "users" do
    alias Lutis.Users.User

    @valid_attrs %{email: "some email", oauth_token: "some oauth_token", username: "some username"}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.oauth_token == "some oauth_token"
      assert user.username == "some username"
    end

    test "update_token/2 updates the user's token" do
      user = user_fixture()
      assert {:ok, updated_user} = Users.update_token(user, "new token")
      assert updated_user.oauth_token == "new token"
    end
  end
end
