class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :ensure_restaurant_exists

  def ensure_restaurant_exists
    redirect_to new_restaurant_registration_path unless Restaurant.any?
  end
end
