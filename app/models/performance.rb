class Performance < ActiveRecord::Base
  belongs_to :event
  
  attr_accessible :location, :address, :zip, :performance_date, :event_id, :min_price, :max_price, :buy_url, 
                  :price_range, :inventory_number, :end_date, :hide_buy_link, :world_premiere, :sold_out, :hide_event,
                  :timeslot, :publish
  
  # Scopes
  scope :find_by_date, lambda { |e_id, date| where("publish = 1 AND event_id = ? AND performance_date >= ? AND performance_date < ?", e_id, date.change(:offset => "-0400"), (date.change(:offset => "-0400")+1.day)).order("performance_date ASC") }
  scope :published, lambda { where(:publish => 1) }
  
  def self.create_or_update(data)
    begin
      performance = Performance.find_by_inventory_number(data[:inv_no])
      if !performance
        performance = Performance.new(:inventory_number => data[:inv_no])      
        performance.set_attributes_from_data(data)      
      else
        performance.update_attributes_from_data(data)
      end      
      performance.save
      if performance.sold_out == 0
        puts performance.id.to_s + "  " + performance.sold_out.to_s
      end
      performance
    rescue Exception => e
      pp "Something bad happened: #{e}"
    end
  end
  
  def save
    event.save
    super
  end
  
  def set_attributes_from_data(data)
    web_content = WebContent.new(data[:web_content])
    self.performance_date  = data[:perf_dt]
    self.inventory_number  = data[:inv_no]
    # self.buy_url           = web_content.buy_url
    self.location          = data[:facility_desc]
    self.price_range       = web_content.price_range.to_s
    self.sold_out          = data[:on_sale_ind]
    self.timeslot          = data[:time_slot_desc]
    self.update_event(data)
  end
  
  def update_attributes_from_data(data)
    web_content = WebContent.new(data[:web_content])
    self.performance_date  = data[:perf_dt]
    self.inventory_number  = data[:inv_no]
    # self.buy_url           = web_content.buy_url
    self.location          = data[:facility_desc]
    self.price_range       = web_content.price_range.to_s
    self.sold_out          = data[:on_sale_ind]
    self.timeslot          = data[:time_slot_desc]
    self.update_event(data)
  end
  
  def update_event(data)
    web_content = WebContent.new(data[:web_content])
    unless self.event.present?
      ev = Event.where("name = ? OR tessitura_name = ?", data[:description], data[:description])
      if ev[0].present?
          self.event = ev[0]
      else
          new_event = Event.new
          new_event.save
          self.event = new_event
      end
      save
    end
    self.event.tessitura_name        = data[:description]
    self.event.tessitura_description = web_content.summary
    save
  end
  
  def ticket_url
     "https://tickets.pifa.org/Cart/Cart.aspx?perf_no=" + inventory_number.to_s
  end
  
  def active_ticket_url
    if buy_url.present?
        return buy_url
    else
        return ticket_url
    end  
  end
  
end
