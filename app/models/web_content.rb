class WebContent
  KEY_TO_CONTENT_TYPE = { 
    :buy_url => 28,
    :summary => 13,
    :price_range => 46 
  }
  
  def initialize(data)
    @data = data
  end
  
  KEY_TO_CONTENT_TYPE.each do |key, id|
    # Defines buy_url, summary, ...
    define_method(key) do
      content_for(key)
    end
  end

  def content_for(key)
    data = @data.detect { |wc| wc[:content_type] == key_to_type(key) }
    data[:content_value] if data
  end

  def key_to_type(key)
    KEY_TO_CONTENT_TYPE[key]
  end
end
