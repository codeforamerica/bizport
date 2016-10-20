class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # saves the location before loading each page so we can return to the
  # right page. If we're on a devise page, we don't want to store that as the
  # place to return to (for example, we don't want to return to the sign in page
  # after signing in), which is what the :unless prevents
  before_filter :store_current_location, unless: :devise_controller?

  before_action :set_checklist_items!
  before_action :dismiss_gt!

  def dismiss_gt!
    if params[:dismissgt] == 'true'
      session[:dismiss_gt] = true
    end
  end

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

  def category_class
    category_class = ''
    page = Comfy::Cms::Page.find_by(full_path: request.path)
    ['plan','launch','grow'].each do |category_name|
      category_class = category_name if (page && page.full_path.match(category_name).present?)
    end
    category_class
  end
  helper_method :category_class

  # Devise's `user_signed_in?` doesn't work when NotSignedInUser is present
  def user_signed_in?
    current_user.instance_of?(User) || false
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  def authenticate_admin_user! # overrides default method from activeadmin
    if user_signed_in? && current_user.role == 'admin'
      true
    elsif user_signed_in? && current_user.role != 'admin'
      not_found
    else
      redirect_to new_user_session_path
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  private

  # override the devise helper to store the current location so we can
  # redirect to it after loggin in or out. This override makes signing in
  # and signing up work automatically.
  def store_current_location
    store_location_for(:user, request.url)
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource)
    if params[:create_new_account] == 'true'
      # corner case only used in profile view (profile.haml)
      path = new_user_registration_path
    else
      path = (stored_location_for(resource) || request.referer || root_path)
    end
    path
  end

  def set_checklist_items!
    # if the user goes somewhere after logging in or signing up
    # they'll have a set of checklist items that need to set accomplishments
    if user_signed_in? && (updates = session[:checklist_updates])
      session.delete(:checklist_updates)
      categories = updates["categories"]
      checklist_items = ChecklistItem.where(
        id: updates["items"].map(&:to_i),
        category: categories
      )
      ChecklistHelper.set_accomplishments(current_user, categories, checklist_items)

      redirect_to updates['source_page'] if updates['source_page']
    end

    @done_ids = []
    @done_ids = current_user.completed_checklist_items.pluck(:id) if current_user.present?
  end
end
