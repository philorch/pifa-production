class Category < ActiveRecord::Base
  has_and_belongs_to_many :events
  
  attr_accessible :description, :name
  
  def class_name
      self.name.split(" ").first.downcase
  end  
end
