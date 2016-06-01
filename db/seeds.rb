ChecklistItem.delete_all

[
  { category_name: 'business_license_determine', checklist_items: [
    { category_name: 'Determine If You Need a Business License', item_text: "Determine if you need a business license" },
  ]},
  { category_name: 'plan', checklist_items: [
    { category_name: 'Plan Out Your Business', item_text: "Write a business plan" },
    { category_name: 'Plan Out Your Business', item_text: "Check out the classes at SBDC" },
    { category_name: 'Plan Out Your Business', item_text: "Get feedback on your business plan" },
    { category_name: 'Plan Out Your Business', item_text: "Connect with a mentor" },
    { category_name: 'Plan Out Your Business', item_text: "Determine if entrepreneurship is right for you right now" },
  ]},
  { category_name: 'finance', checklist_items: [
    { category_name: 'Create a Financial Plan', item_text: "Create a financial plan" },
    { category_name: 'Create a Financial Plan', item_text: "Calculate needed starting capital" },
    { category_name: 'Create a Financial Plan', item_text: "Calculate financial projections" },
    { category_name: 'Create a Financial Plan', item_text: "Calculate your break even point" },
    { category_name: 'Create a Financial Plan', item_text: "Review plan with FREE resources like SBDC" },
    { category_name: 'Create a Financial Plan', item_text: "Explore available loans from the city, the bank, and friends and family" },
  ]},
  { category_name: 'location', checklist_items: [
    { category_name: 'Find a Location', item_text: "Consider home-based vs. brick and mortar" },
    { category_name: 'Find a Location', item_text: "Consider the size of the property you need for your business" },
    { category_name: 'Find a Location', item_text: "Identify several locations well-suited for your business" },
    { category_name: 'Find a Location', item_text: "Get to know the BID services" },
    { category_name: 'Find a Location', item_text: "Consider working with a commercial broker to help with this process" },
    { category_name: 'Find a Location', item_text: "Explore a FREE location selection tool from Gateway Cities Council of Governments " },
    { category_name: 'Find a Location', item_text: "See if your business type is allowed in the locations you've selected" },
    { category_name: 'Find a Location', item_text: "Draft a Letter of Intent (LOI)" },
    { category_name: 'Find a Location', item_text: "Get feedback on your lease by a lawyer or commercial broker" },
    { category_name: 'Find a Location', item_text: "Create a site plan" },
    { category_name: 'Find a Location', item_text: "Draft and sign the lease" },
  ]},
  { category_name: 'register', checklist_items: [
    { category_name: 'Register Your Business', item_text: "Determine your business structure" },
    { category_name: 'Register Your Business', item_text: "Create a business name and consider the branding implications" },
    { category_name: 'Register Your Business', item_text: "Register your Fictitious Business Name (FBN) with LA county" },
    { category_name: 'Register Your Business', item_text: "Apply for a Federal Employer Identification Number " },
    { category_name: 'Register Your Business', item_text: "Apply for a California State Board of Equalization Seller's Permit [Retail Only]" },
    { category_name: 'Register Your Business', item_text: "Determine which licenses and permits are required for your business type" },
    { category_name: 'Register Your Business', item_text: "Apply for a City of Long Beach Business License" },
  ]},
  { category_name: 'business_license_apply', checklist_items: [
    { category_name: 'Apply for a Business License', item_text: "Understand the differences in terminology" },
    { category_name: 'Apply for a Business License', item_text: "Determine what type(s) of business licenses you need" },
    { category_name: 'Apply for a Business License', item_text: "Determine if you need an annual or short-term license" },
    { category_name: 'Apply for a Business License', item_text: "Fill out the Business License Application" },
    { category_name: 'Apply for a Business License', item_text: "Determine if you need to pay Business Improvement District (BID) fees" },
    { category_name: 'Apply for a Business License', item_text: "Determine if you need additional licenses" },
  ]},
  { category_name: 'permits', checklist_items: [
    { category_name: 'Permits', item_text: "Bring plans to the 4th Floor of City Hall for plan check" },
    { category_name: 'Permits', item_text: "Pick up your plans" },
    { category_name: 'Permits', item_text: "Pay permit fees" },
    { category_name: 'Permits', item_text: "Check the status of your permits" },
  ]},
  { category_name: 'inspections', checklist_items: [
    { category_name: 'Inspections', item_text: "Schedule inspections" },
    { category_name: 'Inspections', item_text: "Confirm inspection" },
    { category_name: 'Inspections', item_text: "Meet the inspector" },
    { category_name: 'Inspections', item_text: "Receive Certificate of Occupancy (CO)" },
  ]},
  { category_name: 'grow', checklist_items: [
    { category_name: 'Maintain & Grow Your Business', item_text: "Receive Certificate of Occupancy" },
    { category_name: 'Maintain & Grow Your Business', item_text: "Receive Business License" },
    { category_name: 'Maintain & Grow Your Business', item_text: "Hire employees" },
    { category_name: 'Maintain & Grow Your Business', item_text: "Put up workplace posters" },
    { category_name: 'Maintain & Grow Your Business', item_text: "Pay your business taxes" },
    { category_name: 'Maintain & Grow Your Business', item_text: "Consider joining the Chamber of Commerce" },
    { category_name: 'Maintain & Grow Your Business', item_text: "Make any necessary edits to your Business License" },
    { category_name: 'Maintain & Grow Your Business', item_text: "Start doing business!" },
  ]},
  { category_name: 'city_contracts', checklist_items: [
    { category_name: 'Do Business with the City', item_text: "Register your business services on PlanetBids" },
  ]},
].each do |category|
  category[:checklist_items].each_with_index do |item, index|
    ChecklistItem.create(category: category[:category_name], category_name: item[:category_name], order_number: (index+1), item_text: item[:item_text])
  end
end
