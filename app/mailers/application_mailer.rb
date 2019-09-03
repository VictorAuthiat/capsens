class ApplicationMailer < ActionMailer::Base
  default :to   => 'user@gmail.com',
          :from => 'no-reply@capsens.eu'
end
