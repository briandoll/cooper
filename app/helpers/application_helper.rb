# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

   def all_categories
     Category.all
   end
   
end
