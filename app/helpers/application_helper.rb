module ApplicationHelper
# Define Method to Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Blog System" # Declare string base_title
    if page_title.empty? #check if argument page_title is empty
      base_title # return only base_title
    else 
      "#{page_title} | #{base_title}" #return page_title + base_title
    end
  end
end
