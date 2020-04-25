json.total_items @projects.total_count
json.page @projects.current_page
json.total_pages @projects.total_pages
json.items_per_page @projects.limit_value
json.prev_page @prev_page
json.next_page @next_page

json.projects @projects do |project|
  json.(project, :name, :link, :description)
end


