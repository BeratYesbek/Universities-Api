module Api
  class CitiesController < ApplicationController
    before_action :set_city, only: %i[update show destroy]

    def index

      @cities = City.all
      if !@cities.blank?
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
      
      #File.open("./app/assets/json/cities/nl.json", "w") 
        ActiveSupport::JSON.decode(File.read('./app/assets/json/cities/nl.json')).each do |city|
          state = State.find_by(name: city["admin_name"])
          City.create(name:city["city"],state: state,country_id:1)
          puts city["city"]
        end
  

=begin
      @city = City.create(city_params)
      if @city.valid?
        if @city.save
          @message = "City has been created successfully"
          render json: @city
        else
          render json: "error"
        end
      else
        @message = @city.errors.full_messages
        render json: @message
      end
=end
    end

    def update
      if @city.valid?
        if @city.update(city_params)
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

