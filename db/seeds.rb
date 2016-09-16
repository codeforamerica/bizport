ChecklistItem.delete_all

[
  { category: 'get_idea', category_name: 'Get an Idea', checklist_items: [
    { item_text: "Research what businesses do well in Long Beach" },
    { item_text: "Market research" },
    { item_text: "Find your competitive advantage" },
    { item_text: "Determine how your idea will earn money" },
    { item_text: "Determine if entrepreneurship is right for you right now" },
  ]},
  { category: 'support_options', category_name: 'Support Options', checklist_items: [
    { item_text: "Determine if you need a business license" },
    { item_text: "Check out the SBDC classes" },
    { item_text: "Get a mentor through SCORE" },
    { item_text: "Learn about the Library’s services" },
    { item_text: "Learn how to create an email account" },
    { item_text: "Learn about free wifi spots in Long Beach" },
    { item_text: "Subscribe to the Library Business Book List" },
    { item_text: "Understand the role of the city" },
    { item_text: "Understand benefits and drawbacks of working with friends and family" },
  ]},
  { category: 'business_plan', category_name: 'Business Plan', checklist_items: [
    { item_text: "Write a business plan" },
    { item_text: "Check out the classes at SBDC" },
    { item_text: "Get feedback on your business plan" },
    { item_text: "Connect with a mentor" },
    { item_text: "Determine if entrepreneurship is right for you right now" },
  ]},
  { category: 'financial_plan', category_name: 'Financial Plan', checklist_items: [
    { item_text: "Create a financial plan" },
    { item_text: "Calculate needed starting capital" },
    { item_text: "Calculate financial projections" },
    { item_text: "Calculate your break even point" },
    { item_text: "Review plan with FREE resources like SBDC" },
    { item_text: "Explore available loans from the city, the bank, and friends and family" },
  ]},
  { category: 'business_license_determine', category_name: 'Business License', checklist_items: [
    { item_text: "Determine if you need a business license" },
  ]},
  { category: 'physical_location', category_name: 'Physical Location', checklist_items: [
    { item_text: "Consider home-based vs. brick and mortar" },
    { item_text: "Consider the size of the property you need for your business" },
    { item_text: "Identify several locations well-suited for your business. " },
    { item_text: "Get to know the BID services" },
    { item_text: "Consider working with a commercial broker to help with this process." },
    { item_text: "Explore a FREE location selection tool from Gateway Cities Council of Governments " },
    { item_text: "See if your business type is allowed in the locations you have selected." },
    { item_text: "Draft a Letter of Intent (LOI)" },
    { item_text: "Get feedback on your lease by a lawyer or commercial broker" },
    { item_text: "Create a site plan" },
    { item_text: "Draft and sign the lease" },
  ]},
  { category: 'check_zoning', category_name: 'Check Zoning', checklist_items: [
  ]},
  { category: 'negotiate_lease', category_name: 'Negotiate a Lease', checklist_items: [
  ]},
  { category: 'register', category_name: 'Register Your Business', checklist_items: [
    { item_text: "Determine your business structure" },
    { item_text: "Create a business name and consider the branding implications" },
    { item_text: "Register your Fictitious Business Name (FBN) with LA county" },
    { item_text: "Apply for a Federal Employer Identification Number" },
    { item_text: "Apply for a California State Board of Equalization Seller's Permit [Retail Only" },
    { item_text: "Determine which licenses and permits are required for your business type" },
    { item_text: "Apply for a City of Long Beach Business License" },
  ]},
  { category: 'business_license_apply', category_name: 'Apply for Business License', checklist_items: [
      { item_text: "Understand the differences in terminology" },
      { item_text: "Determine what type(s) of business licenses you need" },
      { item_text: "Determine if you need an annual or short-term license" },
      { item_text: "Fill out the Business License Application" },
      { item_text: "Determine if you need to pay Business Improvement District (BID) fees" },
      { item_text: "Determine if you need additional licenses" },
  ]},
  { category: 'plan_check', category_name: 'Site Plan Check', checklist_items: [
    { item_text: "Bring plans to the 4th floor of City Hall for plan check" },
    { item_text: "Pick up your plans" },
  ]},
  { category: 'permits', category_name: 'Permits', checklist_items: [
    { item_text: "Pay permit fees" },
    { item_text: "Check the status of your permits" },
  ]},
  { category: 'inspections', category_name: 'Inspections', checklist_items: [
    { item_text: "Schedule inspection(s)" },
    { item_text: "Confirm inspection" },
    { item_text: "Meet the inspector" },
    { item_text: "Receive Certificate of Occupancy (CO)" },
  ]},
  { category: 'business_license_receive', category_name: 'Receive Business License', checklist_items: [
    { item_text: "Receive Certificate of Occupancy" },
    { item_text: "Receive Business License" },
    { item_text: "Editing Your License" },
    { item_text: "Closing a Business" },
  ]},
  { category: 'hire_employees', category_name: 'Hire Employees', checklist_items: [
    { item_text: "Hire employees" },
    { item_text: "Put up workplace posters" },
  ]},
  { category: 'business_taxes', category_name: 'Business Taxes', checklist_items: [
    { item_text: "Pay your business taxes" },
  ]},
  { category: 'obtain_funding', category_name: 'Obtain Funding', checklist_items: [
    { item_text: "Understand if you qualify as a minority business owner" },
    { item_text: "Search for opportunities relevant to you" },
  ]},
  { category: 'marketing', category_name: 'Marketing', checklist_items: [
  ]},
  { category: 'city_contracts', category_name: 'Work with the City', checklist_items: [
    { item_text: "Register your business services on PlanetBids" },
  ]},
].each do |category|
  category[:checklist_items].each_with_index do |item, index|
    ChecklistItem.create(category: category[:category], category_name: category[:category_name], order_number: (index+1), item_text: item[:item_text])
  end
end

# Need to have at least one glossary term for the menu to work. 
if GlossaryItem.count < 1 
  GlossaryItem.create(term:'glossary term', definition:"the definition of the glossary term")
end 
