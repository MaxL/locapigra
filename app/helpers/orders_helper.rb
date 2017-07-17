module OrdersHelper
  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    icon = sort_direction == "asc" ? "icon-angle-up" : "icon-angle-down"
    icon = column == sort_column ? icon : ""
    link_to "#{title} <i class='#{icon}'></i>".html_safe, {column: column, direction: direction}
  end
end
