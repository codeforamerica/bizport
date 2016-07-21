class NotSignedInUser
  def checklist_items
    ChecklistItem.none
  end
end
