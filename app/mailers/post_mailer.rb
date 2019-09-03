class PostMailer < ApplicationMailer
  def new_message(from, message)
    @from, @message = from, message
    mail(:subject => 'Testing letter_opener_web')
  end
end
