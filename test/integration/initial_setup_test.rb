require 'test_helper'

class InitialSetupTest < ActionDispatch::IntegrationTest
  test "require restaurant registration on first visit" do
    get root_path
    assert_redirected_to new_restaurant_registration_path
  end

  test "do not allow multiple restaurant registrations" do
    FactoryGirl.create(:restaurant)
    get new_restaurant_registration_path
    assert_redirected_to new_restaurant_session_path
  end
end
