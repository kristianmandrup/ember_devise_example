require 'test_helper'

class SignInEmber < ActionDispatch::IntegrationTest
  # load all the to-be-created fixtures
  fixtures :all

  test "users in the db" do
    assert(User.all.size > 0, "there are users in the db")
  end

  test "signInEmber" do
    # use capybara's javascript driver
    Capybara.current_driver = Capybara.javascript_driver

    # we'll need to create a User fixture with email: 'user0@example.com' & password: 'hellohello'
    # this is a helper function for signing in, since so many integration tests will use need to sign in
    #debugger
    signInEmber('user0@example.com', 'hellohello')

    # assert that the ember.js object responsible for keeping track of signIn state thinks we're logged in
    assert(page.has_content?("Welcome"), 'Page has welcome message')
    signedIn = page.evaluate_script('EmberDeviseExample.userSession.get("signedIn")')
    assert(signedIn, "user is signed in")
  end
end