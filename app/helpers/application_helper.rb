module ApplicationHelper

  #returns full title on per pagebasis
  def full_title(page_title = '')
    base_title = 'Locapigra'
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
