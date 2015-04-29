# encoding: utf-8

class EventImageUploader < ImageUploader

  # Create different versions of your uploaded files:
  version :timeline do
    process :resize_to_fill => [304, 206]
  end

  version :rectangle do
    process :resize_to_fill => [375, 270]
  end

  version :thumbnail do
      process :resize_to_fill => [95, 68]
  end

  # Custom processing
  def splitRectangle
    manipulate! do |source|
      source = source.resize_to_fill(375, 270)
      blank = Magick::Image.new(750, 270) { self.background_color = 'black'}
      blank.composite!(source, 0, 0, Magick::OverCompositeOp)
      #secondary = Magick::Image.read([ self.full_cache_path ]).first
    end
  end
end
