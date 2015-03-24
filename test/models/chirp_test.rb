require 'test_helper'

class ChirpTest < ActiveSupport::TestCase

	def setup
		@user = users(:michael)
		@chirp = @user.chirps.build content: "Lorem ipsum"
	end

	test "should be valid" do
    assert @chirp.valid?
  end

  test "user id should be present" do
    @chirp.user_id = nil
    assert_not @chirp.valid?
  end

  test "content should be present " do
    @chirp.content = "   "
    assert_not @chirp.valid?
  end

  test "content should be at most 140 characters" do
    @chirp.content = "a" * 141
    assert_not @chirp.valid?
  end

  test "order should be most recent first" do
    assert_equal Chirp.first, chirps(:most_recent)
  end

	test "associated chirps should be destroyed" do
    @user.save
    @user.chirps.create!(content: "Lorem ipsum")
		@user.destroy
		assert_equal @user.chirps.count, 0
  end
end
