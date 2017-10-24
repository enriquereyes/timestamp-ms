#!/usr/bin/env ruby 
require "sinatra"
require "date"

get %r{\/([\d]+)} do
  unix = params['captures'].first.to_s
  natural = DateTime.strptime(unix, '%s').to_s
  natural = Date.parse(natural).strftime("%B %e, %Y")

  "<pre>{\"unix\":#{unix}, \"natural\":\"#{natural}\"}</pre>"
end

get %r{\/([\D]+)%20([\d]{2}),%20([\d]{4})} do
  months = DateTime::MONTHNAMES
  days = ('1'..'31').to_a
  month = params['captures'][0]
  day = params['captures'][1]
  date = DateTime.parse(params['captures'].join(","))

  if (months.include? month) && (days.include? day) then
    unix = date.to_time.to_i
    natural = date.strftime("%B %e, %Y")
  else
    natural = 'null'
    unix = 'null'
  end
  
  "<pre>{\"unix\":#{unix}, \"natural\":\"#{natural}\"}</pre>"
end

get "/" do
  erb :home
end

get '/*' do
  '<pre>{"unix":null, "natural":null}</pre>'
end
