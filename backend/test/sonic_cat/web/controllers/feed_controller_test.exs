defmodule SonicCat.Web.FeedControllerTest do
  use SonicCat.Web.ConnCase

  import SonicCat.Factory

  alias SonicCat.Feeds.Feed

  @create_attrs %{author: "some author", description: "some description", image: "some image", name: "some name", url: "some url"}
  @update_attrs %{author: "some updated author", description: "some updated description", image: "some updated image", name: "some updated name", url: "some updated url"}
  @invalid_attrs %{author: nil, description: nil, image: nil, name: nil, url: nil}

  setup %{conn: conn} do
    user = insert(:user)
    {:ok, jwt, full_claims} = Guardian.encode_and_sign(user)

    {:ok, %{conn: put_req_header(conn, "accept", "application/json"), user: user, jwt: jwt, claims: full_claims}}
  end

  test "lists all entries on index", %{conn: conn, jwt: jwt} do
    conn =
      conn
      |> put_req_header("authorization", "User #{jwt}")
      |> get(feed_path(conn, :index))
    assert json_response(conn, 200)["data"] == []
  end

  test "creates feed and renders feed when data is valid", %{conn: conn, user: user, jwt: jwt} do
    new_conn =
      conn
      |> put_req_header("authorization", "User #{jwt}")
      |> post(feed_path(conn, :create), feed: @create_attrs)
    assert %{"id" => id} = json_response(new_conn, 201)["data"]

    new_conn =
      conn
      |> put_req_header("authorization", "User #{jwt}")
      |> get(feed_path(conn, :show, id))
    assert json_response(new_conn, 200)["data"] == %{
      "id" => id,
      "author" => "some author",
      "description" => "some description",
      "image" => "some image",
      "name" => "some name",
      "url" => "some url",
      "user" => %{
        "email" => user.email,
        "first_name" => user.first_name,
        "last_name" => user.last_name,
        "id" => user.id,
      }
    }
  end

  test "does not create feed and renders errors when data is invalid", %{conn: conn, jwt: jwt} do
    conn =
      conn
      |> put_req_header("authorization", "User #{jwt}")
      |> post(feed_path(conn, :create), feed: @invalid_attrs)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen feed and renders feed when data is valid", %{conn: conn, jwt: jwt} do
    %Feed{id: id} = feed = insert(:feed)
    new_conn =
      conn
      |> put_req_header("authorization", "User #{jwt}")
      |> put(feed_path(conn, :update, feed), feed: @update_attrs)
    assert %{"id" => ^id} = json_response(new_conn, 200)["data"]

    new_conn =
      conn
      |> put_req_header("authorization", "User #{jwt}")
      |> get(feed_path(conn, :show, id))
    assert json_response(new_conn, 200)["data"] == %{
      "id" => id,
      "author" => "some updated author",
      "description" => "some updated description",
      "image" => "some updated image",
      "name" => "some updated name",
      "url" => "some updated url",
      "user" => %{
        "email" => feed.user.email,
        "first_name" => feed.user.first_name,
        "last_name" => feed.user.last_name,
        "id" => feed.user.id,
      }
    }
  end

  test "does not update chosen feed and renders errors when data is invalid", %{conn: conn, jwt: jwt} do
    feed = insert(:feed)
    conn =
      conn
      |> put_req_header("authorization", "User #{jwt}")
      |> put(feed_path(conn, :update, feed), feed: @invalid_attrs)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen feed", %{conn: conn, jwt: jwt} do
    feed = insert(:feed)
    new_conn =
      conn
      |> put_req_header("authorization", "User #{jwt}")
      |> delete(feed_path(conn, :delete, feed))
    assert response(new_conn, 204)
    assert_error_sent 404, fn ->
      conn
      |> put_req_header("authorization", "User #{jwt}")
      |> get(feed_path(conn, :show, feed))
    end
  end
end
