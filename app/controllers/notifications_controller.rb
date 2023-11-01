class NotificationsController < ApplicationController
	
	def index
		notifications = Notification.where.not(id: @current_user.id)
		if notifications.present?
			render json: {message: "Notifications fetch successfully", data: notifications}, status: :ok
		else
			render json: {message: "You don't have any notifications"}, status: :bad_request
		end
	end

end