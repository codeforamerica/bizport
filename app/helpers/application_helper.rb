module ApplicationHelper

  include Comfy::CmsHelper
  def self.next_step_page_service(component, request)
    page = Comfy::Cms::Page.find_by(full_path: request.path)
    next_page = Comfy::Cms::Page.published.where(parent_id: page.parent_id).where('position > ?', page.position).order(:position).first
    case component
    when "title"
      if next_page
        return "Next: #{next_page.label}"
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

end
