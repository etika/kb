
# TwilioRest a module to send the message through twilio client
module TwilioRest
# this will send just the normal sms
def send_message(phone_number,activation_token)
  binding.pry
  number_to_send_to = phone_number
  @twilio_client = Twilio::REST::Client.new APP_CONFIG['TWILIO_SID'], APP_CONFIG['TWILIO_TOKEN']

 @twilio_client.messages.create(
                :from => "+1#{APP_CONFIG['TWILIO_PHONE_NUMBER']}",
                :to => number_to_send_to,
                :body =>"Security Code is #{activation_token}"
                )

end

def whatsapp_message

 #message=@twilio_client.messages.create(
                # from:'whatsapp:+14155238886',
                # body:"Security Code is loooooooooooooooooooooooooooooloo",
                # to: 'whatsapp:+917678459298'
                # )
 message = @client.messages
                  .create(
                     from: 'whatsapp:+552120420682',
                     body: 'Your appointment is coming up on July 21 at 3PM',
                     to: 'whatsapp:+17678459298'
                   )
if !message.media_url.present?
  set_category(message)
end
end

def set_category(message)
  event =Event.create(message: message)
  Keyword.all.each do|Keyword|
   if event.message.include?(keyword.name)
    event.category_id= keyword.category_id
  else
    event.category_id = Category.where(name: "Uncoded")
   end
   event.save
  end
end
end
