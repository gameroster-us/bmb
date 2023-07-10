class TwilioService
  def initialize
    @client = Twilio::REST::Client.new
  end
  
  def send_sms(to, body)
    begin
      response = @client.messages.create(
        from: '+15418593842',
        to: '+917984471511',
        body: 'Hi this is the otp'
      )
    end 
  end
  
end


  