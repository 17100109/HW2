class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
   
    if params[:sort_by]
      @movies= Movie.order(params[:sort_by])
      @h1='hilite'
    elsif params[:release_by]
      @movies= Movie.order(params[:release_by])
      @h2='hilite'
    else
      @movies = Movie.all
      @h= ""
    end
      
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end
  
  def update_path1
  end
  
  def update_path2
    @up1= params[:movie]
    @up2= Movie.find_by(title: @up1[:search1])
    if (@up2)
      @k1 = @up1[:title]
      @k2 = @up1[:rat]
      @k3 = @up1[:rel_date]
      if @k1=='' || @k2=='' || @k3==''
        flash[:notice]="One of the fields is empty"
      else
        @up2.update_attributes!(movie_params)
        flash[:notice]="Movie has been updated"
      end
    else
      flash[:notice]="Movie cannot be found"
    end  
    redirect_to movies_path
  end
  
  def delete_path1
  end
  
  def delete_path2
  @del1 = params[:movie]
  @del2 = Movie.find_by(title: @del1[:search1])
  @del3 = Movie.where(rating: @del1[:search2]).all
  if(@del2)
    @del2.delete
    flash[:notice]= "Movie Deleted"
  elsif(@del3)
    @del3.each {|x| x.delete}
    flash[:notice]= "Movie Deleted"
  else
    flash[:notice]= "Movie cannot be found"
  end
  
  
  redirect_to movies_path
  
  
  end



  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
