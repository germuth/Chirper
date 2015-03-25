class ApplicationMailer < ActionMailer::Base
  default from: "noreply@chirper.com"
  layout 'mailer'
end
