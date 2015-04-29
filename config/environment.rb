# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Pifa2013::Application.initialize!

$CALENDAR = {:start => DateTime.new(2013,3,28), :end => DateTime.new(2013,4,27), :test => DateTime.new(2013,3,28)}