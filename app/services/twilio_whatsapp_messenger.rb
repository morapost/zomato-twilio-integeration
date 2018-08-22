class TwilioWhatsappMessenger
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def call
    client = Twilio::REST::Client.new
    client.messages.create({
      from: 'whatsapp:+14155238886',
      to: 'whatsapp:+919894609671',
      body: message
    })
  end
end