module Api
  class UniversitiesController < ApplicationController
    before_action :set_university, only: %i[update show destroy]
    def index
      @universities = University.all
      if @universities.blank?
        render json: @universities
      end
    end

    def show
      @university = University.find(params[:id])
      if @universities.blank?
        render json: @university
      end
    end

    def create
      @university = University.create(university_params)
      if @university.valid?
        if @university.save
          @message = "University has been created successfully"
          render json: @university
        else
          handler_error
        end
      else
        @message = @university.errors.full_messages
        handler_error
      end
    end

    def update
      if @university.valid?
        if @university.update(university_params)
          @message = "University has been created successfully"
          render json: @university
        else
          handler_error
        end
      else
        @message = @university.errors.full_messages
        handler_error
      end
    end

    def destroy
      if @university.destroy
        @message = "University has been deleted successfully"
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

    def set_university
      @university = University.find(params[:id])
    end

    def university_params
      params.permit(:name, :country_id, :city_id)
    end

  end
end
