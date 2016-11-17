class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_user


  def show
    # current_user available now
    userID = current_user.id 
    courseID = current_lesson.section.course.id

    @valid = false
    current_lesson.section.course.enrollments.each do |enrollment|
      if enrollment.user_id == @userID && enrollment.course_id == @courseID
        @valid = true 
        break
      end
    end
    if !@valid
      redirect_to course_path(current_lesson.section.course)_
    end
  end

  private

  def require_authorized_for_current_user_1
    #if current_course.user != current_user
    #  render text: "Unauthorized", status: :unauthorized
    #end
    userID = current_user.id 
    courseID = current_lesson.section.course.id

    valid = false
    current_lesson.section.course.enrollments.each do |enrollment|
      if enrollment.user_id == userID && enrollment.course_id == courseID
        valid = true
        break
      end
    end

    if !valid
      render text: "Not enrolled", status: :unauthorized
    end
  end

  def require_authorized_for_current_user
    course = current_lesson.section.course
    if !current_user.enrolled_in?(course)
      redirect_to course_path(course), alert: "You are not enrolled in this course."
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
