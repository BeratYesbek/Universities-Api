class ParseController < ApplicationController
  require  './app/services/turkey.rb'
  def turkey_parse
    Turkey.new.parse_university
  end

  def german_parse

  end


end
