module Api
  class UniversitiesController < ApplicationController
    before_action :set_university, only: %i[update show destroy]

    def index
      @universities = University.all
      if !@universities.blank?
        render :index, state: :ok
      end
    end

    def get_by_country_id
      @universities = University.where(country_id: params['country_id'])
      render json: @universities

    end

    def get_by_city_id
      @universities = University.where(city_id: params['city_id'])
      render json: @universities
    end

    def get_by_state_id
      state = State.find(id: params['state_id'])
      @universities = University.joins(:city).where('cities.state_id = ?', state.id)
      render json: @universities
    end

    def get_by_country_name
      @universities = University.joins(:country).where('LOWER(countries.name) = ?', params['name'].downcase)
      render json: @universities
    end

    def get_by_state_name
      state = State.find_by('LOWER(name) = ?', params['name'].downcase)
      @universities = University.joins(:city).where('cities.state_id = ?', state.id)
      render json: @universities
    end

    def get_by_city_name
      @universities = University.joins(:city).where('LOWER(cities.name) = ?', params['name'].downcase)
      render json: @universities
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
