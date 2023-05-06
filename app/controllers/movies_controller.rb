class MoviesController < ApplicationController
  def new
   @movie = MOvie.new(title: "hi", description: "bye")
   @movie.save
  end

  def index
    @movies = Movie.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html
    end
  end

  def show
    @movie = Movie.find(params.fetch(:id))
  end

  def create
   movie_attributes = params.require(:movie).permit(:title, :description)
    @movie = Movie.new(movie_attributes)
    if @movie.valid?
        @movie.save
        redirect_to movies_url, notice: "Movie Created Successfully."
    else
      render "new"
    end
  end

  def edit
    @movie = Movie.find(params.fetch(:id))
  end

  def update
    @movie = Movie.find(params.fetch(:id))

    @movie.title = params.fetch(:title)
    @movie.description = params.fetch(:description)

    if @movie.valid?
      @movie.save
      redirect_to movie_url(@movie), notice: "Movie Created Successfully."
    else
      redirect_to movie_url(@movie), alert: "Movie failed to Update Sucessfully."
    end
  end

  def destroy
    the_id = params.fetch(:id)
    the_movie = Movie.where({ :id => the_id }).first

    the_movie.destroy

    redirect_to("/movies", { :notice => "Movie deleted successfully."} )
  end
end
