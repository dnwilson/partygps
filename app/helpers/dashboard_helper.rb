module DashboardHelper

	def dashboard_action_path(heading, options={})
		if options.present?
			"/dashboard/#{heading}/#{options}"
		else
			"/dashboard/#{heading}"
		end
	end
end