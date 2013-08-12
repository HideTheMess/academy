class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user, url)
    @user = user
    @url = url

    mail(to: user.email, subject: 'Welcome to MusicApp')
  end

  def reminder_email(user, url)
    @user = user
    @url = url

    mail(to: user.email, subject: 'Welcome to MusicApp')
  end
end
