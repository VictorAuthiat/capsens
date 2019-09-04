class PostsController < ApplicationController
  def new
  end

  def create
    PostMailer.new_message(params[:email], params[:message]).deliver_now
  end
end
