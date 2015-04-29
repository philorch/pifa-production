# encoding: utf-8

class CreditImageUploader < ImageUploader

  process :resize_to_fill => [150, 100]

end
