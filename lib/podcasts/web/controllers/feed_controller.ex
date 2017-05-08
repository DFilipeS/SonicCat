defmodule Podcasts.Web.FeedController do
  import Podcasts.Web.ViewHelpers
  use Podcasts.Web, :controller

  alias Podcasts.Feeds.Feed
  alias Podcasts.Repo

  def index(conn, _params) do
    user = current_user(conn) |> Repo.preload(:feeds)
    render conn, "index.html", feeds: user.feeds
  end

  def show(conn, %{"id" => id}) do
    feed = Repo.get(Feed, id)
    render conn, "show.html", feed: feed
  end

  @doc """
  Render new feed page.
  """
  def new(conn, _params) do
    changeset = Podcasts.Feeds.feed_changeset(%Feed{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"feed" => params}) do
    case Podcasts.Feeds.create_feed(Map.put(params, "user_id", current_user(conn).id)) do
      {:ok, _feed} ->
        conn
        |> put_flash(:info, "Feed added successfully!")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
