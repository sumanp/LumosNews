class RequestsController < ApplicationController

  def create
    @request = Request.new(request_params)
    if @request.save
      RequestMailer.request_received(@request).deliver
      RequestMailer.welcome(@request).deliver
      
      redirect_to home_thankyou_path,:notice => "Thank you!"
    else
      redirect_to root_path, :notice => "Woaah! Please try again"

    end
  end

  private
  def request_params
    params.require(:request).permit(:name, :email)
  end
end
