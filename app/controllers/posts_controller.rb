class PostsController < ApplicationController
  def new
  end

  def create
    PostMailer.new_message(params[:email], params[:message]).deliver_now
    redirect_to '/', notice: "Email sent successfully, please check letter_opener_web's inbox."
  end
end
