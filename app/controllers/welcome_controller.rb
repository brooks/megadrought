class WelcomeController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  require 'uri'
  require 'net/http'

  def index
    retrieve_measurement(Date.current)
  end

  def retrieve_measurement(date)
    if @measurement = Measurement.find_by_date(date)
      @measurement
    else
      begin
        data = Nokogiri::HTML.parse(http_request.body).css('td')
        percent = data.last.content.sub(/%/, '').to_i
        @measurement = Measurement.create_by_date_and_percent(date, percent)
      rescue
        @measurement = Measurement.create_by_date_and_percent(date, 0)
      end
    end
  end

  def http_request
    Net::HTTP.post_form(URI.parse('http://cdec.water.ca.gov/cdecapp/snowapp/getSWCState.action'), query_params)
  end

  def query_params
    {
      'actualDate' => yesterday('%m/%d/%y'),
      'actualDatePlus1' => today('%m/%d/%y'),
      'querydate' => yesterday('%d-%b-%Y')
    }
  end

  def today(format)
    Date.today.strftime(format)
  end

  def yesterday(format)
    Date.yesterday.strftime(format)
  end
end
