class CoursesController < ApplicationController
  before_action :set_course, only: %i[show update destroy]

  def index
    @courses = Course.includes(:author).all
    render json: CourseBlueprint.render_as_json(@courses)
  end

  def show
    render json: CourseBlueprint.render_as_json(@course)
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      render json: CourseBlueprint.render_as_json(@course), status: :created, location: course_url(@course)
    else
      render json: { errors: @course.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @course.update(course_params)
      render json: CourseBlueprint.render_as_json(@course)
    else
      render json: { errors: @course.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    head :no_content
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :author_id)
  end
end
