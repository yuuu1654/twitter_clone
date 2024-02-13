# frozen_string_literal: true

class ApplicationController < ActionController::Base

	private

	def logged_in_user?
		if !user_signed_in?
			redirect_to new_user_session_path
		end
	end
end
