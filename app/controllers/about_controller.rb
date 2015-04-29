class AboutController < HomeController

    http_basic_authenticate_with :name => "PIFApress", :password => "PIFAimages", :only => "press_protected"
  
    def index
        
    end

    def pifa_slideshow
      @images = "transe_express.jpg", "eiffel_tower.jpg", "ballet.jpg", "red_band.jpg", "garden.jpg", "play.jpg", "fashion.jpg"
    	render :template => "home/modal", :layout => "blank"
  	end

  	def contact
  	end

  	def partners
  	end

  	def press
  	  @press_releases = PressRelease.where(["publish_date < ?", Time.now]).order('publish_date DESC, created_at DESC')
  	end

    def press_protected
      
    end

  	def privacy
  	end

  	def sponsors
  	end

  	def tickets
  	end
  
end