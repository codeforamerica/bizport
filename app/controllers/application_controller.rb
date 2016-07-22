class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
end
