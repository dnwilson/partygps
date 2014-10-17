class Users::SessionsController < Devise::SessionsController
	before_filter :disable_nav, only: [:new]

end