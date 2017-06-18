defmodule SonicCat.FeedsTest do
  use SonicCat.DataCase

  import SonicCat.Factory

  alias SonicCat.Feeds

  describe "feeds" do
    alias SonicCat.Feeds.Feed

    @valid_attrs %{author: "some author", description: "some description", image: "some image", name: "some name", url: "some url"}
    @update_attrs %{author: "some updated author", description: "some updated description", image: "some updated image", name: "some updated name", url: "some updated url"}
    @invalid_attrs %{author: nil, description: nil, image: nil, name: nil, url: nil}

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
      valid_attrs = Enum.into(@valid_attrs, %{user_id: user.id})

      assert {:ok, %Feed{} = feed} = Feeds.create_feed(valid_attrs)
      assert feed.author == "some author"
      assert feed.description == "some description"
      assert feed.image == "some image"
      assert feed.name == "some name"
      assert feed.url == "some url"
    end

    test "create_feed/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feeds.create_feed(@invalid_attrs)
    end

    test "update_feed/2 with valid data updates the feed" do
      feed = insert(:feed)
      assert {:ok, feed} = Feeds.update_feed(feed, @update_attrs)
      assert %Feed{} = feed
      assert feed.author == "some updated author"
      assert feed.description == "some updated description"
      assert feed.image == "some updated image"
      assert feed.name == "some updated name"
      assert feed.url == "some updated url"
    end

    test "update_feed/2 with invalid data returns error changeset" do
      feed = insert(:feed)
      assert {:error, %Ecto.Changeset{}} = Feeds.update_feed(feed, @invalid_attrs)
      assert feed == Feeds.get_feed!(feed.id)
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
