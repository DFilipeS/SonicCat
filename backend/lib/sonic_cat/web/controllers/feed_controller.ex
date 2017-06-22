defmodule SonicCat.Web.FeedController do
  use SonicCat.Web, :controller

  import SonicCat.Web.ViewHelpers

  alias SonicCat.Repo
  alias SonicCat.Feeds
  alias SonicCat.Feeds.Feed

  action_fallback SonicCat.Web.FallbackController

  def index(conn, _params) do
    feeds = Feeds.list_feeds()
    render(conn, "index.json", feeds: feeds)
  end

  def create(conn, %{"url" => url}) do
    feed_params = %{"url" => url, "user_id" => current_user(conn).id}
    with {:ok, %Feed{} = feed} <- Feeds.create_feed(feed_params) do
      feed = Repo.preload(feed, :user)

      conn
      |> put_status(:created)
      |> put_resp_header("location", feed_path(conn, :show, feed))
      |> render("show.json", feed: feed)
    end
  end

  def show(conn, %{"id" => id}) do
    feed = Feeds.get_feed!(id)
    render(conn, "show.json", feed: feed)
  end

  def delete(conn, %{"id" => id}) do
    feed = Feeds.get_feed!(id)
    with {:ok, %Feed{}} <- Feeds.delete_feed(feed) do
      send_resp(conn, :no_content, "")
    end
  end
end
