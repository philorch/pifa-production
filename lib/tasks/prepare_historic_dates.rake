
desc "This task migrates all provides events without historic years with historic years"
task :prepare_historic_dates => :environment do
  events = Event.all
  events.each do |event|
    if event.historic_year.nil? && event.historic_date.present?
      event.historic_year = event.historic_date.year
      event.save
    end
  end
end