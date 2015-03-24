require 'test_helper'

class ChirpsInterfaceTest < ActionDispatch::IntegrationTest
	def setup 
		@user = users(:michael)
	end

  test "chirp interface" do
    log_in_as @user
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Chirp.count' do
      post chirps_path, chirp: { content: "" }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = "This chirp really ties the room together"
    assert_difference 'Chirp.count', 1 do
      post chirps_path, chirp: { content: content }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
    first_chirp = @user.chirps.paginate(page: 1).first
    assert_difference 'Chirp.count', -1 do
      delete chirp_path(first_chirp)
    end
    # Visit a different user.
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
