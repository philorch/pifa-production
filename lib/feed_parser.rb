require 'rubygems'
require 'rest-client'
require 'nokogiri'
require 'date'

module Tessitura; end

module Tessitura::FeedParser

  FEED_URL = 'http://kimmelcenter.org/pifa/datafeed.php?full=true'

  module Conversions
    TO_INTEGER = lambda { |x| x.to_i }
    TO_STRING  = lambda { |x| x.to_s }
    TO_BOOLEAN = lambda { |x| x.to_s == "Y" }
    TO_DATE    = lambda { |x| DateTime.strptime(x) }
  end

  PERFORMANCES_TYPE_MAP = {
    :inv_no              => Conversions::TO_INTEGER,
    :description         => Conversions::TO_STRING,
    :type                => Conversions::TO_STRING, # write a lambda to convert these types after we know what they are
    :text1               => Conversions::TO_STRING,
    :text2               => Conversions::TO_STRING,
    :perf_dt             => Conversions::TO_DATE,
    :composerln          => Conversions::TO_STRING, # looks like a templated string?
    :on_sale_ind         => Conversions::TO_BOOLEAN,
    :performance_type    => Conversions::TO_STRING, # is this mappable?
    :perf_type_id        => Conversions::TO_INTEGER,
    :seat_ind            => Conversions::TO_BOOLEAN,
    :print_ind           => Conversions::TO_BOOLEAN,
    :zmap_no             => Conversions::TO_INTEGER,
    :facility_no         => Conversions::TO_INTEGER,
    :facility_desc       => Conversions::TO_STRING,
    :prod_season_no      => Conversions::TO_INTEGER,
    :season_no           => Conversions::TO_INTEGER,
    :season_desc         => Conversions::TO_STRING,
    :start_dt            => Conversions::TO_DATE,
    :end_dt              => Conversions::TO_DATE,

    # these two look like a mapping inline -- maybe we can abuse that
    :perf_status         => Conversions::TO_INTEGER,
    :perf_status_desc    => Conversions::TO_STRING,
    :time_slot           => Conversions::TO_INTEGER,
    :time_slot_desc      => Conversions::TO_STRING,

    :ga_ind              => Conversions::TO_BOOLEAN,

    :text3               => Conversions::TO_STRING,
  }

  CREDIT_TYPE_MAP = {
    :credit_type         => Conversions::TO_STRING,
    :role_no             => Conversions::TO_INTEGER,
    :role_desc           => Conversions::TO_STRING,
    :full_name           => Conversions::TO_STRING,
    :artist_no           => Conversions::TO_INTEGER,
    :rank                => Conversions::TO_INTEGER
  }

  WEB_CONTENT_MAP = {
    :orig_inv_no         => Conversions::TO_INTEGER,
    :inv_no              => Conversions::TO_INTEGER,
    :inv_type            => Conversions::TO_STRING,
    :content_type        => Conversions::TO_INTEGER,
    :content_type_desc   => Conversions::TO_STRING,
    :content_value       => Conversions::TO_STRING
  }

  def self.parse_block!(obj, item = { }, map = PERFORMANCES_TYPE_MAP)
    obj.children.each do |child|
      next if child.text?
      next unless map[child.name.to_sym]

      value = map[child.name.to_sym].call(child.inner_text)
      item[child.name.to_sym] = value
    end

    return item
  end

  def self.performances
    results = []

    http_result = RestClient.get(FEED_URL)

    raise "oh snaps" unless http_result.code == 200

    doc = Nokogiri::XML.parse(http_result)

    performances = doc.xpath('//PerformanceDetail')

    performances.each do |performance|
      perf = performance.xpath('Performance')
      results.push(item = parse_block!(perf.first))

      credits = item[:credits] ||= []
      performance.xpath('Credit').each do |cred|
        credits.push(cred_item = { })
        parse_block!(cred, cred_item, CREDIT_TYPE_MAP)
      end

      content = item[:web_content] ||= []
      performance.xpath('WebContent').each do |wc|
        content.push(wc_item = { })
        parse_block!(wc, wc_item, WEB_CONTENT_MAP)
      end
    end

    return results
  end

  def self.sync_feed
    performances.each do |perf|
      Performance.create_or_update(perf)
    end
  end
end


#
# if you need to test the parsing features of the library, just running it, e.g.:
#
# $ ruby feed_parser.rb
#
# Will barf out the data structure it gets back from the FEED_URL.
#
# $ ruby feed_parser.rb sync
#
# Will attempt to sync against the development database.
#
if __FILE__ == $0
  if ARGV[0] == "sync"
    require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))
    require 'pp'
    pp Tessitura::FeedParser.performances
    Tessitura::FeedParser.sync_feed
  else
    require 'pp'
    pp Tessitura::FeedParser.performances
  end
end
