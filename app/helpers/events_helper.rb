module EventsHelper
  def active_page?(option)
    'active' if (option.eql?("index") && params[:option].nil?) || params[:option].eql?(option)
  end
end
