class WelcomeController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  require 'uri'
  require 'net/http'

  def index
    @actual_date_plus_one = Date.today.strftime('%m/%d/%y')
    @actual_date = Date.yesterday.strftime('%m/%d/%y')
    @query_date = Date.yesterday.strftime('%d-%b-%Y')

    params = {'actualDate' => @actual_date, 'actualDatePlus1' => @actual_date_plus_one, 'querydate' => @query_date}
    x = Net::HTTP.post_form(URI.parse('http://cdec.water.ca.gov/cdecapp/snowapp/getSWCState.action'), params)

    doc = Nokogiri::HTML.parse(x.body)
    data = doc.css('td')
    
    @percent = data.last.content[0..1].to_i/100.to_f
    @tot = 400-(400 * @percent)
  end
end