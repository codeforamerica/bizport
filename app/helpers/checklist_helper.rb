module ChecklistHelper
  def self.set_accomplishments(user, checklist_categories, checklist_items)
    ActiveRecord::Base.transaction do
      user.accomplishments
        .joins(:checklist_item)
        .where(checklist_items: { category: checklist_categories })
        .destroy_all
      checklist_items.each do |item|
        user.accomplishments.create!(checklist_item: item)
      end
    end
  end
end