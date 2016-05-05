class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Comfy::CmsHelper
  # used in CMS "step" pages to set up "next page" links
  def next_step_page(component)
    page = Comfy::Cms::Page.find_by(full_path: request.path)
    # TODO: Refactor from Ruby logic into query for speed
    next_page = Comfy::Cms::Page.where(position: page.position+1).select{ |p| p.categories.any?{|c| c.label == "Step" } }.first
    case component
    when "title"
      if next_page
        return "Step #{next_page.position}: #{next_page.label}"
      else
        return "Return to Homepage"
      end
    when "path"
      if next_page
        return next_page.full_path
      else
        return "/"
      end
    end
  end
  helper_method :next_step_page
end
