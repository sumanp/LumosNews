class RequestsController < ApplicationController

  def create
    @request = Request.new(request_params)
    if @request.save
      redirect_to home_thankyou_path
    else
      redirect_to :back, :notice => "Wooah! Please try again "

    end
  end

  private
  def request_params
    params.require(:request).permit(:name, :email)
  end
end
