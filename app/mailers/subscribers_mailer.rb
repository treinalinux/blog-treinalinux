class SubscribersMailer < ApplicationMailer
  def new_posts
    @posts = params[:posts]
    @subscriber = params[:subscriber]

    mail to: @subscriber[:email]
  end
end
