crumb :root do
  link "メルカリ", root_path
end

crumb :categories do
  link "カテゴリー一覧", categories_path
  parent :root
end

crumb :mypage do
  link "マイページ", mypage_path
  parent :root
end

crumb :edit_profile do |edit|
  link "プロフィール編集", edit_profile_path(edit)
  parent :mypage
end

crumb :logout do |logout|
  link "ログアウト", logout_path(logout)
  parent :mypage
end

crumb :identification do |identification|
  link "本人情報の登録", identification_path(identification)
  parent :mypage
end


crumb :category_show do |category|
  link "#{category.name}", categories_path(category)
  parent :categories
end

crumb :product do |product|
  link "#{product.name}", product_path(product)
end

crumb :product_search do |keyword|
  link "#{keyword}", root_path
end

crumb :user_show do |user|
  link "#{user.profile.nickname}さんのマイページ", user_path(user)
end

crumb :user_listings do |user|
  link "出品した商品 - 出品中", listings_user_path(user)
  parent :user_show, user
end

crumb :user_in_progress do |user|
  link "出品した商品 - 取引中", in_progress_user_path(user)
  parent :user_show, user
end

crumb :user_completed do |user|
  link "出品した商品 - 売却済", completed_user_path(user)
  parent :user_show, user
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