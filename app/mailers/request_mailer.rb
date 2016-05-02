class RequestMailer < ActionMailer::Base

  def request_received(request)

    @request = request

    mail( to: "sumanpuri55@gmail.com",
          from: "suman@instarter.com",
          subject: "New Request Received",
        )
  end

  def welcome(request)

    @request = request

    mail( to: @request.email,
          from: "Suman <suman@instarter.com>",
          subject: "Welcome to Instarter",
        )
  end
end
