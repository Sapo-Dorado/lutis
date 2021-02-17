defmodule Lutis.PostingTest do
  use Lutis.DataCase

  alias Lutis.Posting

  describe "posts" do
    alias Lutis.Posting.Post
    alias Lutis.Users

    @valid_attrs %{"contents" => "some contents", "title" => "some title"}
    @update_attrs %{"contents" => "some updated contents", "title" => "some updated title"}
    @invalid_attrs %{"contents" => nil, "title" => nil}

    @user_attrs %{email: "valid@email.com", username: "some username"}

    def fixture(:user) do
      {:ok, user} = Users.create_user(@user_attrs)
      user
    end

    def post_fixture(attrs \\ %{}) do
      user = fixture(:user)
      {:ok, post} =
        Posting.create_post(user.id, Enum.into(attrs, @valid_attrs))

      Posting.get_post!(post.id)
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posting.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posting.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      user = fixture(:user)
      assert {:ok, %Post{} = post} = Posting.create_post(user.id, @valid_attrs)
      assert post.author == user.id
      assert post.contents == @valid_attrs["contents"]
      assert post.title == @valid_attrs["title"]
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posting.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Posting.update_post(post, @update_attrs)
      assert post.contents == @update_attrs["contents"]
      assert post.title == @update_attrs["title"]
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posting.update_post(post, @invalid_attrs)
      assert post == Posting.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posting.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posting.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posting.change_post(post)
    end
  end
end
