defmodule SonicCat.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: SonicCat.Repo

  alias SonicCat.Accounts.User
  alias SonicCat.Feeds.Feed

  def user_factory do
    %User{
      first_name: "User",
      last_name: sequence(:user_name, &"#{&1}"),
      email: sequence(:user_email, &"email-#{&1}@test.com"),
      password_hash: "$2b$12$OJPVj/68yaqoiiyjDwoKB.SSg2joqVThV9J2XmWKn80a2oh1PrYQO" # Hash value for "123456"
    }
  end

  def feed_factory do
    %Feed{
      author: sequence(:feed_author, &"Author #{&1}"),
      description: "Random description",
      image: "Image url",
      name: sequence(:feed_name, &"Feed #{&1}"),
      url: "http://random.com/feed",
      user: build(:user)
    }
  end

end
