class CarsController < ApplicationController

	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	before_action :check_ownership!, only: [:edit, :update, :destroy]

	def new
		@car = Car.new
	end

	def create
		@car = current_user.cars.build(car_params)
		if @car.save
			flash[:success] = "You have succesfully added a car model"
			redirect_to current_user
		else
			render 'new'
		end
	end

	def edit
		@car = Car.find_by_id([params[:id]])
	end

	def update
		@car = Car.find_by_id([params[:id]])
		if @car.update_attributes(car_params)
			flash[:success] = "Car model updated"
			redirect_to current_user
		else
			render 'edit'
		end
	end

	def destroy
		Car.find_by_id(params[:id]).destroy
		flash[:success] = "You have succesfully deleted your model from your set"
		redirect_to current_user
	end

	private

	def car_params
		params.require(:car).permit(:model, :battery_capacity)
	end

	def check_ownership!
		if (!current_user.cars.ids.include?(params[:id].to_i))
			flash[:danger] = "You don't have the authorization to perform this action"
			redirect_to current_user
		end
	end



end
