class PostMailer < ApplicationMailer
  def new_post
    @post = params[:post]
    mail(to: 'notification@post.com', subject: 'New post was created')
  end
end
