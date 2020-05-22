class WorksController < ApplicationController
  def index
    @works_albums = Work.by_category("album")
    @works_movies = Work.by_category("movie")
    @works_books  = Work.by_category("book")
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end
  end
  
  def new 
    @work = Work.new
  end
    
  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Work added successfully"
      redirect_to work_path(@work.id)
    else
      flash.now[:warning] = "Work not added"
      render :new
    end
  end
    
  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end
  end
  
  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Work updated successfully"
      redirect_to work_path(@work.id)
    else
      flash.now[:warning] = "Work not updated"
      render :edit
    end
  end
  
  def destroy
    work = Work.find_by(id: params[:id])
    if work.nil?
      head :not_found
      return
    end
    work.destroy
    flash[:success] = "Work deleted successfully"
    redirect_to works_path
  end

  def upvote
    work = Work.find_by(id: params[:id])
    if work.nil?
      head :not_found
      return
    end
    user = User.find_by(id: session[:user_id])
    if user.nil?
      flash[:warning] = "You must log in to do that"
      redirect_to work_path(work.id)
      return
    end
    if work.upvote(user)
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(work.id)
      return
    else
      flash[:warning] = "Could not upvote. User: has already voted for this work"
      redirect_to work_path(work.id)
      return
    end
  end

  private

  def work_params
    return params.require(:work).permit(
      :category, :title, :creator, :publication, :description
    )
  end
end
