class SmsController < ApplicationController
    skip_after_action :verify_authorized
    def send_sms
      client = Twilio::REST::Client.new('AC489da7c9dbf2cd29f7df83101b56d40b', '8582e4e474ec259ae74a20de02f22fd4')
      message = client.messages.create(
        body: 'Otp For Slot Booking App',
        messaging_service_sid: 'MGa4558d42b2a3db7fe4d8f66e415e0fd3',
        to: '+917984471511'
      )
  
      
    response = {
        sid: message.sid,
        status: message.status,
        to: message.to,
        from: message.from,
        body: message.body,
        num_segments: message.num_segments
      }
     p response
      render json: response
    end

  end
  