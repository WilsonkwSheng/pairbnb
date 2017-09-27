require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
	def new_mail( charset="UTF-8" )
	  mail = Mail.new
	  mail.mime_version = "1.0"
		  if charset
		    mail.content_type ["text", "plain", { "charset" => charset }]
		  end
	  mail
	end
end
