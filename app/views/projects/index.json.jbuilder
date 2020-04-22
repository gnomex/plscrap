json.total_items @projects.total_count
json.page @projects.current_page
json.items_per_page @projects.limit_value
json.next_page @link

json.projects @projects do |project|
  json.(project, :name, :link, :description)
end


