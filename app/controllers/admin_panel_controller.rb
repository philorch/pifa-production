class AdminPanelController < ApplicationController
  
    before_filter :authenticate_admin!

    def events
        @events = Event.all(:order => "name")
    end

    def show_event
        @event = Event.find(params[:id])
    end
  
    def new_event
        @event = Event.new
        @select_options = Event.all
        3.times do
            similar_event = @event.similar_events.build
        end
    end
  
    def edit_event
        @event = Event.find(params[:id])
        @select_options = Event.except(@event)
        similar = @event.similar_events.count
        if similar < 3
            (3-similar).times do
                similar_event = @event.similar_events.build
            end
        end
    end
    
    def tessitura_sync
        require 'feed_parser'
        Tessitura::FeedParser.sync_feed
        @sync_page = true;
    end

end