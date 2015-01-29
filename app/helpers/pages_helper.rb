module PagesHelper

  def get_search_item(search_item)
    search_item = eval(search_item.searchable_type).find(search_item.searchable_id)
  end
end
