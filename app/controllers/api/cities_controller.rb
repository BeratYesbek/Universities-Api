module Api
  class CitiesController < ApplicationController
    before_action :set_city, only: %i[update show destroy]

    def index
      @cities = City.all
      if @cities.blank?
        render json: @cities
      end
    end

    def show
      @city = City.find(params[:id])
      if @city.blank?
        render json: @city
      end
    end

    def create
      @city = City.create(state_params)
      if @city.valid?
        if @city.save
          @message = "City has been created successfully"
          render json: @city
        else
          handler_error
        end
      else
        @message = @city.errors.full_messages
        handler_error
      end
    end

    def update
      if @city.valid?
        if @city.update(state_params)
          @message = "City has been created successfully"
          render json: @city
        else
          handler_error
        end
      else
        @message = @city.errors.full_messages
        handler_error
      end
    end

    def destroy
      if @city.destroy
        @message = "City has been deleted successfully"
        render json: @message
      else
        @message = "During the process an error has occurred."
        handler_error
      end
    end

    private

    def handler_error
      render :errors, status: :bad_request
    end

    def set_city
      @city = City.find(params[:id])
    end

    def city_params
      params.permit(:name,:country_id,:state_id)
    end
  end
end

