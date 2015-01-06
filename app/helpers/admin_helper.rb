module AdminHelper

	def admin_action_path(heading, options={})
		if options.present?
			"/admin/#{heading}/#{options}"
		else
			"/admin/#{heading}"
		end
	end
end