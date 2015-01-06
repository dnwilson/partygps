module ApplicationHelper
	def full_title
		basetitle = "PARTYGPS"
		if content_for(:title).present?
			"#{basetitle} | #{content_for(:title)}"
		else
			basetitle
		end
	end
end
