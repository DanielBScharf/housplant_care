class PlantsController < ApplicationController
  def index
    @plants = Plant.all
    if params[:query].present?
      @plants = @plants.search(params[:query])
    end
  end

  def show
    @plant = Plant.find(params[:id])
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(plant_params)
    @plant.house = current_user.house

    if @plant.save
      redirect_to plant_path(@plant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @plant = Plant.find(params[:id])
  end

  def destroy
    @plant = Plant.find(params[:id])
    @plant.destroy
    redirect_to plants_path, status: :see_other
  end

  private

  def plant_params
    params.require(:plant).permit(:nickname, :watering, :name, :common_name, :scientific_name, :cycle, :watering, :sunlight, :image)
  end
end
