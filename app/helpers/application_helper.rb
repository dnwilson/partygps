module ApplicationHelper
	def full_title
		basetitle = "PARTYGPS"
		if content_for(:title).present?
			"#{basetitle} | #{content_for(:title)}"
		else
			basetitle
		end
	end

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield(presenter) if block_given?
    presenter
  end

  def login_or_register_page?
    current_page?(login_path) || current_page?(register_path)
  end
end
