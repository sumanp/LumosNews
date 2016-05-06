class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index]

  def index
    @events = Event.paginate(:page => params[:page], per_page: 20).order('start_date')
  end

  def show

  end

  def new
    @event = current_user.events.build
  end

  def edit
    authorize! :update, @event
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to new_event_path, notice: 'Event Created'
    else
      redirect_to :back, notice: 'Something went wrong'
    end
  end

  def update
    authorize! :update, @event
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to events_path, notice: 'Event Updated' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @event
    @event.destroy
    redirect_to :back, notice: 'Event Deleted'
  end



  private

  def event_params
    params.require(:event).permit(:title, :description, :url, :start_date, :end_date, :cover_image)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
