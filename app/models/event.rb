require 'rubygems'
require 'chronic'

class Event < ActiveRecord::Base

  has_many :performances
  has_many :similar_events, :dependent => :destroy
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :tags
  
  attr_accessible :artistic_credit, :description, :historic_date, :historic_description, 
  					:name, :performer, :location, :address, :zip, :similar_events_attributes, :category_ids, 
            :image, :image_cache, :image2, :image2_cache, :credit_image, :credit_image_cache,
            :historic_format, :publish, :ticket_override, :ticketing_end, :price_range_override, :web_address, :historic_year, :tag_ids, :date_text_override,
            :show_default_purchase_button

  accepts_nested_attributes_for :similar_events, :reject_if => lambda { |a| a[:similar_id].nil? }, allow_destroy: true
  
  # validates :artistic_credit, :description, :historic_date, :historic_description, :name, :performer, :presence => true

  searchable do
    text :name, :performer, :historic_description, :tessitura_name, :boost => 5.0
    text :location, :address, :boost => 4.0
    text :description, :artistic_credit, :tessitura_description, :artistic_credit, :ticket_override
    integer :publish
    date :historic_date
    text :p_location do
      performances.map { |performance| performance.location }
    end
  end
  
  handle_asynchronously :solr_index
  handle_asynchronously :remove_from_index

  # Mount carrierwave uploader and validate
  mount_uploader :image, EventImageUploader
  mount_uploader :image2, EventImageUploader
  mount_uploader :credit_image, CreditImageUploader
  validates_integrity_of :image, :image2, :credit_image
  validates_processing_of :image, :image2, :credit_image
  
  # Scopes
  scope :except, lambda { |event| {:conditions => ["id != ?", event.id]} }
  scope :by_date, lambda { |day| includes(:performances).where("performances.performance_date >= ? AND performances.performance_date < ?", day.change(:offset => "-0400"), (day.change(:offset => "-0400")+1.day)) }
  # Combine these scopes
  # scope :with_performances, lambda { includes(:performances).where("performances.id IS NOT NULL") }
  # scope :published, lambda { {:conditions => {:publish => 1}} }
  scope :published, lambda { includes(:performances).where("events.publish = 1 AND performances.id IS NOT NULL AND performances.publish = 1").order("name ASC") }
  scope :in_historic_order, lambda { includes(:performances).where("events.publish = 1 AND performances.id IS NOT NULL AND performances.publish = 1").order("historic_year ASC, historic_date ASC") }

  def start_date
    self.performances.order("performance_date ASC").first.performance_date
  end

  def end_date
    self.performances.order("performance_date ASC").last.performance_date
  end

  def get_dates
    all_perfs = self.performances.published.order("performance_date ASC")
    all_dates = all_perfs.map{ |x| x.performance_date.to_date }.uniq
    unique_dates = []
    all_perfs.each do |perf|
        unique_dates << perf.performance_date.to_date.to_datetime if all_dates.include?(perf.performance_date.to_date)
        all_dates.delete(perf.performance_date.to_date)
    end
    unique_dates
  end

  def date_range
    if (self.start_date.to_date == self.end_date.to_date)
      return start_date.strftime("%B %d")
    elsif (get_dates.size == 2) 
      return start_date.strftime("%B %d") + " & " + end_date.strftime("%d")
    elsif (self.start_date.month == self.end_date.month)
      return start_date.strftime("%B %d") + " - " + end_date.strftime("%d")
    else
      return start_date.strftime("%B %d") + " - " + end_date.strftime("%B %d")
    end
  end

  def next_performance
    # Convert UTC to EST
    now = DateTime.now - 4.hours
    self.performances.where("performance_date >= ?", now).order("performance_date ASC").first
  end

  def historic_date_str
    if date_text_override.present?
      return date_text_override
    else
      if historic_year.present? && historic_year > 0 && historic_date.present?
        if historic_date.year < 1000
          return historic_date.year.to_s+" AD"
        else
          return historic_date.strftime("%b %d, %Y")
        end
      elsif historic_year.present?
        return (historic_year * -1).to_s + " BC"
      else
        return "The Great Unknown"
      end
    end
  end

  def historic_format
    historic_date.strftime("%m/%d/%Y") if historic_date
  end

  def historic_format=(str)
    self.historic_date = Chronic.parse(str) if str.present?
  end
  
  def name
    if self[:name].present?
        return self[:name]
    else
        return self[:tessitura_name]
    end
  end
  
  def description
    if self[:description]
        return self[:description]
    else
        return self[:tessitura_description]
    end
  end
  
  def price_range
     if price_range_override.present?
         return price_range_override
     elsif next_performance.present?
         return next_performance.price_range
     else
       return nil
     end
  end
  
end
