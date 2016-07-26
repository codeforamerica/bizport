class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # saves the location before loading each page so we can return to the
  # right page. If we're on a devise page, we don't want to store that as the
  # place to return to (for example, we don't want to return to the sign in page
  # after signing in), which is what the :unless prevents
  before_filter :store_current_location, :unless => :devise_controller?

  # used in CMS "step" pages to set up "next page" links
  def next_step_page(component)
    ApplicationHelper.next_step_page_service(component, request)
  end
  helper_method :next_step_page

  include Comfy::CmsHelper
  def page_slug
    Comfy::Cms::Page.find_by(full_path: request.path).slug
  end
  helper_method :page_slug

  # NotSignedInUser allows for handy empty associations and such
  def current_user
    super || NotSignedInUser.new
  end

  # Devise's `user_signed_in?` doesn't work when NotSignedInUser is present
  def user_signed_in?
    current_user.instance_of?(User) || false
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  private

  # override the devise helper to store the current location so we can
  # redirect to it after loggin in or out. This override makes signing in
  # and signing up work automatically.
  def store_current_location
    store_location_for(:user, request.url)
  end
end
