class CompetenciesController < ApplicationController
  before_action :set_competency, only: %i[show update destroy]

  def index
    @competencies = Competency.all
    render json: CompetencyBlueprint.render_as_json(@competencies)
  end

  def show
    render json: CompetencyBlueprint.render_as_json(@competency)
  end

  def create
    @competency = Competency.new(competency_params)

    if @competency.save
      render json: CompetencyBlueprint.render_as_json(@competency), status: :created, location: competency_url(@competency)
    else
      render json: { errors: @competency.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @competency.update(competency_params)
      render json: CompetencyBlueprint.render_as_json(@competency)
    else
      render json: { errors: @competency.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @competency.destroy
    head :no_content
  end

  private

    def set_competency
      @competency = Competency.find(params[:id])
    end

    def competency_params
      params.require(:competency).permit(:name)
    end
end
