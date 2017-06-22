defmodule SonicCat.Web.FeedControllerTest do
  use SonicCat.Web.ConnCase

  import SonicCat.Factory

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
      |> post(feed_path(conn, :create), url: "http://feeds.feedburner.com/rc-as-baladas-de-dr-paixao")
    assert %{"id" => id} = json_response(new_conn, 201)["data"]

    new_conn =
      conn
      |> put_req_header("authorization", "User #{jwt}")
      |> get(feed_path(conn, :show, id))
    assert json_response(new_conn, 200)["data"] == %{
      "id" => id,
      "author" => "Nuno Markl",
      "description" => "As Baladas de Dr. Paixão é uma rubrica de amor das Manhãs da Comercial.",
      "image" => "http://radiocomercial.iol.pt/upload/B/baladas-14001.png",
      "name" => "Rádio Comercial - As Baladas de Dr Paixão",
      "url" => "http://feeds.feedburner.com/rc-as-baladas-de-dr-paixao",
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
      |> post(feed_path(conn, :create), url: "http://localhost")
    assert json_response(conn, 422)["error"] == "Invalid URL"
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
