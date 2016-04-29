class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Comfy::CmsHelper
  # used in CMS "step" pages to set up "next page" links
  def next_step_page(component)
    page = Comfy::Cms::Page.find_by(full_path: request.path)
    next_page = Comfy::Cms::Page.find_by(position: page.position+1)
    case component
    when "title"
      return "Step #{next_page.position}: #{next_page.label}"
    when "path"
      return next_page.full_path
    end
  end
  helper_method :next_step_page
end
