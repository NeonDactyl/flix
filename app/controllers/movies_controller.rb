class MoviesController < ApplicationController

  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    case params[:scope]
    when "upcoming"
      @movies = Movie.unreleased
    when "recent"
      @movies = Movie.recent
    when "flops"
      @movies = Movie.flops
    when "hits"
      @movies = Movie.hits
    else
      @movies = Movie.released
    end
  end

  def show
    @fans = @movie.fans
    @genres = @movie.genres

    if current_user
      @current_fav = current_user.favorites.find_by(movie_id: @movie.id)
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie Updated"
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie Added"
    else
      render :new
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_url, alert: "Movie Deleted"
  end

private

  def set_movie
    @movie = Movie.find_by!(slug: params[:id])
  end

  def movie_params
    params.require(:movie).
      permit(:title, :description, :rating, :released_on, :total_gross, :cast, :director, :duration, :image_file_name, genre_ids: [])
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_url, alert: "Unauthorized access!"
    end
  end


end
