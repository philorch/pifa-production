class EventsController < ApplicationController
  
  before_filter :authenticate_admin!, :only => ["create", "update", "destroy"]
  
  def index
      @events = Event.in_historic_order
      @events_by_history = Event.in_historic_order
  end
  
  def show
      
      @event = Event.find(params[:id])
      #set location
      if @event.next_performance.present? && @event.next_performance.location?
        @location = @event.next_performance.location
      elsif @event.location?
        @location = @event.location
      end
      #set address
      if @event.next_performance.present? &&  @event.next_performance.address?
        @address = @event.next_performance.address
      elsif @event.address?
        @address = @event.address
      end
      #set zip
      if @event.next_performance.present? && @event.next_performance.zip?
        @zip = @event.next_performance.zip
      elsif @event.zip?
        @zip = @event.zip
      end
      
      last_performance = nil
      @performances_with_unique_locations = []
      @event.performances.each do |perf|
          if last_performance.nil? || perf.location != last_performance.location
              @performances_with_unique_locations << perf
          end
          last_performance = perf
      end
        
  end

  def by_category
      @category = Category.find(params[:id])
      @events = @category.events.in_historic_order
      render 'index'
  end
  
  def by_tag
      @tag = Tag.find(params[:id])
      @events = @tag.events.in_historic_order
      render 'index'
  end
  
  def by_day
      @date = params[:day].to_datetime
      @events = Event.by_date(@date).published
      render 'index'
  end

  def free_feed
    @category = Category.find(6) # '6' is the free category
    @events = @category.events.in_historic_order
    respond_to do |format|
     format.xml
    end  
  end

  # Admin stuff ------------------------------ *
  
  def create
    @event = Event.new(params[:event])
    @select_options = Event.all
    if @event.save
        redirect_to admin_events_path, :notice => "Successfully created event."
    else
        render admin_new_event_path
    end
  end
  
  def update
    @event = Event.find(params[:id])
    @select_options = Event.except(@event)
    if @event.update_attributes(params[:event])
        redirect_to admin_show_event_path(@event), :notice => "Successfully updated event."
    else
        redirect_to admin_edit_event_path
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to admin_events_path, :notice => "Successfully deleted event."
  end
  
end