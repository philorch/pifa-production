class Story < ActiveRecord::Base
  attr_accessible :body, :title, :url_link, :text_color, :image, :image_cache
  
  validates :text_color, :presence => true

  # Mount carrierwave uploader and validate
  mount_uploader :image, StoryImageUploader
  validates_presence_of :image
  validates_integrity_of :image
  validates_processing_of :image

  def color_name
  	case self.text_color
  		when 1
  			return "black"
  		when 2
  			return "white"
  	end
  end
end
