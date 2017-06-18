defmodule SonicCat.Web.AuthControllerTest do
  use SonicCat.Web.ConnCase

  import SonicCat.Factory

  describe "auth_controller" do
    test "POST /api/register successfully registers a user with correct data", %{conn: conn} do
      conn = post conn, "/api/register", %{email: "test@test.com", password: "Test Password", first_name: "John", last_name: "Doe"}

      response = json_response(conn, 200)
      assert response
      assert response["exp"]
      assert response["token"]
      assert response["user"]["id"]
      assert response["user"]["first_name"] == "John"
      assert response["user"]["last_name"] == "Doe"
      assert response["user"]["email"] == "test@test.com"
    end

    test "POST /api/login successfully logins with a valid user credentials", %{conn: conn} do
      user = insert(:user)
      conn = post conn, "/api/login", %{email: user.email, password: "123456"}

      response = json_response(conn, 200)
      assert response
      assert response["exp"]
      assert response["token"]
      assert response["user"]["id"] == user.id
      assert response["user"]["first_name"] == user.first_name
      assert response["user"]["last_name"] == user.last_name
      assert response["user"]["email"] == user.email
    end
  end
end
