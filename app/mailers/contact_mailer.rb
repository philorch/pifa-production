class ContactMailer < ActionMailer::Base
  
  default :to => "aharting@kimmelcenter.org",
  		  :from => "notification@pifa.org"

  def contact_email(contact)
  	@contact = contact
  	email_with_name = "#{contact[:firstname]} #{contact[:lastname]} <#{contact[:email]}>"
  	mail(:from => email_with_name, :subject => "Test Email")
  end
  
end
