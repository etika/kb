
# TwilioRest a module to send the message through twilio client
module TwilioRest
# this will send just the normal sms
def send_message(phone_number,activation_token)
  number_to_send_to = phone_number
   @twilio_client = Twilio::REST::Client.new APP_CONFIG['TWILIO_SID'], APP_CONFIG['TWILIO_TOKEN']
  @twilio_client.messages.create(
                :from => "+1#{APP_CONFIG['TWILIO_PHONE_NUMBER']}",
               :to => number_to_send_to,
                 :body =>"Security Code is #{activation_token}"
                )
end

def listing_whatsapp_message
   @twilio_client = Twilio::REST::Client.new APP_CONFIG['TWILIO_SID'], APP_CONFIG['TWILIO_TOKEN']
   #will list all the messages sent to this whatsapp number on or after that date

   @messages = @twilio_client.messages.list(
                              to:'whatsapp:+14155238886',
                              date_sent_after:  Event.last.present? ? Event.last.start_date : Date.today-1.days
                           )

 @messages.each do |m|
  phone_number =m.from.split("+")[1]
  user = User.where(phone_number: phone_number).last
  if  user.account_activated?
    set_category(m)
  end
end
end

def set_category(message)
  event =Event.new(message: message.body,start_date: message.date_sent, user_id:1)
   puts "---", event.id
  Keyword.all.each do|keyword|
    if event.message.include?(keyword.name)
      event.category_id = keyword.category_id
    else
      event.category_id = Category.where(name: "Uncoded").last.id
    end
   event.save
  end
end
end
