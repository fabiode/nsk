class ApplicationMailer < ActionMailer::Base
  add_template_helper CouponsHelper
  default from: 'Klasme + Niina Secrets <nsk@klasme.com>'
  layout 'mailer'
end
