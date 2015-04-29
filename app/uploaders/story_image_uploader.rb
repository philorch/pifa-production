# encoding: utf-8

class StoryImageUploader < ImageUploader
 
  # Create different versions of your uploaded files:
  version :slideshowBg do
    process :resize_to_fill => [560, 340]
  end
end
