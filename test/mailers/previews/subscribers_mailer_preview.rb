# Preview all emails at http://localhost:3000/rails/mailers/subscribers_mailer
class SubscribersMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/subscribers_mailer/new_posts
  def new_posts
    SubscribersMailer.new_posts
  end

end
