class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :string_to_date, only: %i[index]

  # GET /events
  def index
    #@events = Event.all
    #@events = Event.by_user(@current_user_id)
    @events = Event.where(
                  user_id: @current_user_id
                  ).from_date(
                    @from
                  ).to_date(
                    @to
                  )
    
    render json: @events
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  private
    def string_to_date
      fromFilterDate = params[:FromFilterDate].split("-").map(&:to_i)
      toFilterDate = params[:ToFilterDate].split("-").map(&:to_i)
      @from = DateTime.new(fromFilterDate[0],fromFilterDate[1], fromFilterDate[2])
      @to = DateTime.new(toFilterDate[0],toFilterDate[1], toFilterDate[2])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(
        :title, 
        :description,
        :start_date, 
        :end_date, 
        :start_time, 
        :end_time, 
        :user_id
      )
    end
end
