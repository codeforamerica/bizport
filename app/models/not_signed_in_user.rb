class NotSignedInUser
  def checklist_items
    ChecklistItem.none
  end

  def admin?
    false
  end
end
