class HousesController < ApplicationController
  def index
    @house = House.all
  end

  def show
    @house = House.find(params[:id])
  end

  def new
    House.new
  end

  def create
    House.new
    @house.user = current_user
    @house.name = house_params

    if @house.save
      redirect_to house_path(@house)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @house = House.find(params[:id])
    if @house.update(house_params)
      redirect_to house_path(@house)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @house = House.find(params[:id])
    @house.destroy
    redirect_to house_path, status: :see_other
  end

  private

  def house_params
    params.require(:house).permit(:name)
  end
end
