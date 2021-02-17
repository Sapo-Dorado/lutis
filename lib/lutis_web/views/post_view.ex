defmodule LutisWeb.PostView do
  use LutisWeb, :view
  alias LutisWeb.PostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      author: post.author,
      title: post.title,
      contents: post.contents,
      upvotes: post.upvotes,
      views: post.views}
  end
end
