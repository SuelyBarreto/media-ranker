class WorksController < ApplicationController
  def index
    @works = Work.all
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
    @work.available = true
    if @work.save
      flash[:success] = "Work added successfully"
      redirect_to work_path(@work.id)
    else
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
      redirect_to work_path(@work.id)
    else
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
    redirect_to works_path
  end


  private

  def work_params
    return params.require(:work).permit(
      :category, :title, :creator, :publication, :description
    )
  end
  
end
