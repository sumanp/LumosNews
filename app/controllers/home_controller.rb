class HomeController < ApplicationController
  def index
  end

  def thankyou
    @request = Request.last
  
  end
end
