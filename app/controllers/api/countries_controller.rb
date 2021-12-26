module Api
  class CountriesController < ApplicationController
    before_action :set_country, only: %i[update show destroy]

    def index
      @countries = Country.all
      if @countries.blank?
        render json: @countries
      end
    end

    def show
      @country = Country.find(params[:id])
      if @country.blank?
        render json: @country
      end
    end

    def create
      @country = Country.create(country_params)
      if @country.valid?
        if @country.save
          @message = "Country has been created successfully"
          render json: @country
        else
          handler_error
        end
      else
        @message = @country.errors.full_messages
        handler_error
      end
    end

    def update
      if @country.valid?
        if @country.update(country_params)
          @message = "Country has been created successfully"
          render json: @country
        else
          handler_error
        end
      else
        @message = @country.errors.full_messages
        handler_error
      end
    end

    def destroy
      if @country.destroy
        @message = "Country has been deleted successfully"
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

    def set_country
      @country = Country.find(params[:id])
    end

    def country_params
      params.permit(:name)
    end
  end
end
