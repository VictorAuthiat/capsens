class ApplicationMailer < ActionMailer::Base
  default :to   => 'user@gmail.com',
          :from => 'no-reply@capsens.eu'

  def new_message(from, message)
    @from, @message = from, message
    mail(:subject => 'Testing letter_opener_web', :template_name => 'new_message')
  end
end
