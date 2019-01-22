class ApplicationMailer < ActionMailer::Base
  add_template_helper CouponsHelper
  default from: 'nsk@klasme.com'
  layout 'mailer'
end
