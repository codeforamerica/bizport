class NotSignedInUser
  def checklist_items
    ChecklistItem.none
  end

  def accomplishments
    Accomplishment.none
  end

  def admin?
    false
  end
end
