defmodule SonicCat.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: SonicCat.Repo

  alias SonicCat.Accounts.User

  def user_factory do
    %User{
      first_name: "User",
      last_name: sequence(:user_name, &"#{&1}"),
      email: sequence(:user_email, &"email-#{&1}@test.com"),
      password_hash: "$2b$12$OJPVj/68yaqoiiyjDwoKB.SSg2joqVThV9J2XmWKn80a2oh1PrYQO" # Hash value for "123456"
    }
  end

end
