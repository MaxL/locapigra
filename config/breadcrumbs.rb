crumb :root do
  link "Home", root_path
end

crumb :comics do
  link "Comics", comics_path
end

crumb :comic do |comic|
  link comic.name, comic_path(comic)
  parent :comics
end

crumb :products do
  link "Shop", shop_path
end

crumb :product do |product|
  link product.name, product_path(product)
  parent :products
end

crumb :blogs do
  link "Blog", blogs_path
end

crumb :about do
  link "About", about_path
end
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
