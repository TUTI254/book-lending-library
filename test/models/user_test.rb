require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email_address: "user@example.com", password: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should require email address" do
    @user.email_address = ""
    assert_not @user.valid?, "User should be invalid without an email address"
  end

  test "should require password" do
    user_without_password = User.new(email_address: "user@example.com", password: nil)
    assert_not user_without_password.valid?, "User should be invalid without a password"
  end

  test "should normalize email address" do
    @user.email_address = " User@Example.Com "
    @user.save
    assert_equal "user@example.com", @user.reload.email_address
  end
end
