class PostMailer < ApplicationMailer
  def new_message(from, message)
    @from, @message = from, message
    mail(:subject => 'Testing letter_opener_web')
  end

  def new_csv(from, to, message)
    @from, @to, @message = from, to, message
    mail(:subject => 'Testing csv export')
  end
end
