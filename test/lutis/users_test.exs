defmodule Lutis.UsersTest do
  use Lutis.DataCase

  alias Lutis.Users

  describe "users" do
    alias Lutis.Users.User

    @valid_attrs %{email: "test@email.com", username: "some username"}
    @invalid_email "invalid@email.com"

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.email == @valid_attrs.email
    end

    test "add_username/2 with valid email adds username and returns error otherwise" do
      user = user_fixture()
      assert user.username == nil
      assert {:ok, %User{} = user} = Users.add_username(@valid_attrs.email, @valid_attrs.username)
      assert user.username == @valid_attrs.username
      assert {:error, _ } = Users.add_username(@invalid_email, "en")
    end

    test "get_user/1 returns the corresponding user and nil otherwise" do
      user = user_fixture()
      assert user.email == Users.get_user(user.email).email
      assert nil == Users.get_user("Invalid email")
    end

    test "usernames are unique" do
      user_fixture()
      user_fixture(%{email: "otheremail@test.com"})
      Users.add_username(@valid_attrs.email, @valid_attrs.username)
      assert {:error, _} = Users.add_username("otheremail@test.com", @valid_attrs.username)
    end
  end
end
