class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :required_enrollment_for_current_user

	def show
	end

	private
	helper_method :current_lesson
	def current_lesson
		@current_lesson ||= Lesson.find(params[:id])
	end

	def required_enrollment_for_current_user
		unless current_user.enrolled_in?(current_lesson.section.course)
			redirect_to course_path(current_lesson.section.course), :alert => 'Please enroll in the course before viewing the lessons'
		end
	end
end
