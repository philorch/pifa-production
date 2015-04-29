class Contact < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :email, :firstname, :lastname, :message, :zip

  validates :email, :firstname, :lastname, :message, :presence => true
end
