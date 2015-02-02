module PagesHelper

  def get_search_item(search_item)
    search_item = eval(search_item.searchable_type).find(search_item.searchable_id)
  end

  def get_events(search_documents)
    @events = []
    search_documents.each do |search_item|
      if search_item.searchable_type.eql?("Event")
        @events << Event.find(search_item.searchable_id)
      elsif search_item.searchable_type.eql?("Location")
        location_events = Location.find(search_item.searchable_id).upcoming_events
        location_events.each{ |e| @events << e}
      end
    end
  end
end
