class PlantsController < ApplicationController

  def index
    @plants = Plant.all
    if params[:query].present?
      @plants = @plants.search(params[:query])
    end
  end

  def show
    @plants = Plant.all
    if params[:query].present?
      @plants = @plants.search(params[:query])
    end
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

  def find_plants
    plants = []
    key = ENV.call('API_Key')
    url = "https://perenual.com/api/species-list?page=1&key=#{key}"
    response = RestClient.get(url)
    data = JSON.parse(response)
    plants = data['plants']
    plants.each do |plant|
      plants << { scientific_name: plant["scientific_name"],
                  id: plant['id'],
                  common_name: plant["commong_name"],
                  other_name: plant["other_name"],
                  watering: plant["watering"],
                  sunlight: plant["sunlight"],
                  image: "https://perenual.com/storage/species_image/#{id}_#{scientific_name}/og/49255769768_df55596553_b.jpg"}
    end
    plants
  end

  def plant_params
    params.require(:plant).permit(:nickname, :watering, :name, :common_name, :scientific_name, :cycle, :watering, :sunlight, :image)
  end
end
