module Api
  class StatesController < ApplicationController
    before_action :set_state, only: %i[update show destroy]

    def index
      @states = State.all
      if @states.blank?
        render json: @states
      end
    end

    def show
      @state = State.find(params[:id])
      if @state.blank?
        render json: @state
      end
    end

    def create
      @state = State.create(state_params)
      if @state.valid?
        if @state.save
          @message = "State has been created successfully"
          render json: @state
        else
          handler_error
        end
      else
        @message = @state.errors.full_messages
        handler_error
      end
    end

    def update
      if @state.valid?
        if @state.update(state_params)
          @message = "State has been created successfully"
          render json: @state
        else
          handler_error
        end
      else
        @message = @state.errors.full_messages
        handler_error
      end
    end

    def destroy
      if @state.destroy
        @message = "State has been deleted successfully"
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

    def set_state
      @state = State.find(params[:id])
    end

    def state_params
      params.permit(:name)
    end
  end
end
