class HomeController < ApplicationController
    # require 'simple-rss'
    require 'htmlentities'

    def index
        @stories = Story.find(:all, :order => "id")
        @events_by_history = Event.in_historic_order
        # @tumblr_feed = Feedzirra::Feed.fetch_and_parse("http://pifa-philly.tumblr.com/tagged/timetravel2/rss")
        begin
          tumblr = open('http://pifa-philly.tumblr.com/tagged/timetravel2/rss')
        end 
        if tumblr.present?
          @tumblr_feed = SimpleRSS.parse tumblr
        end
        @html_decoder = HTMLEntities.new
    end

    def streetfair
    end  
    
    def search
        search = Event.search do
          fulltext params[:q]
          with :publish, 1
        end
        @search_term = params[:q]
        @search_results = search.results
    end

    def streetfair_slideshow
      @images = "transe_express3.jpg", "transe_express2.jpg", "ferris_wheel2.jpg", "fountain_woman.jpg", "fair.jpg", "facepaint.jpg"
      render :action => "modal", :layout => "blank"
    end

    def modal
    end

    def blog
    end

end