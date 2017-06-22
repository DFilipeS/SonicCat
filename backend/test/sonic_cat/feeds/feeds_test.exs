defmodule SonicCat.FeedsTest do
  use SonicCat.DataCase

  import SonicCat.Factory

  alias SonicCat.Feeds

  describe "feeds" do
    alias SonicCat.Feeds.Feed

    test "list_feeds/0 returns all feeds" do
      feed = insert(:feed)
      assert Feeds.list_feeds() == [feed]
    end

    test "get_feed!/1 returns the feed with given id" do
      feed = insert(:feed)
      assert Feeds.get_feed!(feed.id) == feed
    end

    test "create_feed/1 with valid data creates a feed" do
      user = insert(:user)
      attrs = %{"url" => "http://feeds.feedburner.com/rc-as-baladas-de-dr-paixao", "user_id" => user.id}

      assert {:ok, %Feed{} = feed} = Feeds.create_feed(attrs)
      assert feed.author == "Nuno Markl"
      assert feed.description == "As Baladas de Dr. Paixão é uma rubrica de amor das Manhãs da Comercial."
      assert feed.image == "http://radiocomercial.iol.pt/upload/B/baladas-14001.png"
      assert feed.name == "Rádio Comercial - As Baladas de Dr Paixão"
      assert feed.url == "http://feeds.feedburner.com/rc-as-baladas-de-dr-paixao"
    end

    test "create_feed/1 with invalid data returns error changeset" do
      user = insert(:user)
      attrs = %{"url" => "http://localhost", "user_id" => user.id}
      assert {:error, "Invalid URL"} = Feeds.create_feed(attrs)
    end

    test "delete_feed/1 deletes the feed" do
      feed = insert(:feed)
      assert {:ok, %Feed{}} = Feeds.delete_feed(feed)
      assert_raise Ecto.NoResultsError, fn -> Feeds.get_feed!(feed.id) end
    end

    test "change_feed/1 returns a feed changeset" do
      feed = insert(:feed)
      assert %Ecto.Changeset{} = Feeds.change_feed(feed)
    end
  end
end
