class AuthorsController < ApplicationController
  before_action :set_author, only: %i[show update destroy]

  def index
    authors = Author.all
    render json: AuthorBlueprint.render_as_json(authors)
  end

  def show
    render json: AuthorBlueprint.render_as_json(@author)
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      render json: AuthorBlueprint.render_as_json(@author), status: :created, location: author_url(@author)
    else
      render json: { errors: @author.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @author.update(author_params)
      render json: AuthorBlueprint.render_as_json(@author)
    else
      render json: { errors: @author.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if AuthorDeletionService.new(@author.id).call
      render json: { message: 'Author was successfully deleted and courses reassigned.' }, status: :ok
    else
      render json: { error: 'Failed to delete author.' }, status: :unprocessable_entity
    end
  end

  private
  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name)
  end
end
