class KeepEventsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_filter :authenticate_user!

  def index

    @events = current_user.keep_events.paginate(:page => params[:page], per_page: 30).order('created_at DESC')
  end

  def create
    if Keep.create(kept: @event, user: current_user)
      redirect_to :back, notice: 'Kept in Mind'
    else
      redirect_to :back, alert: 'Something went wrong...*sad pingu*'
    end
  end

  def destroy
    Keep.where(kept_id: @event.id, user_id: current_user.id).first.destroy
    redirect_to :back, notice: 'Forgot'
  end

  private

  def set_event
    @event = Event.find(params[:event_id] || params[:id])
  end
end
