class Restaurants::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :ensure_restaurant_exists, only: [:new, :create]
  before_filter only: [:new] { redirect_to new_restaurant_session_path if Restaurant.any? }
end
