ActiveAdmin.register ChecklistItem do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params :item_text, :category, :category_name, :order_number

end
