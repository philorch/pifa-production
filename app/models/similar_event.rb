class SimilarEvent < ActiveRecord::Base
  belongs_to :event
  
  attr_accessible :similar_id, :event_id

  # Don't save similar event entries with blank similar_id
  after_validation { |similiar| similiar.destroy if similiar.similar_id.blank? }
  # Remove similar event entries if the similar_id is blank
  after_save { |similiar| similiar.destroy if similiar.similar_id.blank? }

end
