require 'rubygems'
require 'hirb'
require 'hashie'
require 'httparty'
require 'isna'
require "assembla_cli/version"

module Assembla
  include HTTParty
  format :xml
  base_uri 'assembla.com'

  def self.xml_headers
   {:headers => {'Accept' => 'application/xml'}}
  end

  def self.login (login_name, password)
    @login_name = login_name
    @password = password

    basic_auth(login_name, password)
  end

  def self.spaces
    self.get('/spaces/my_spaces', xml_headers)
  end

  def self.space (space_name)
    @current_space = self.get("/spaces/#{space_name}", xml_headers)['space']
  end

  def self.my_report (report_id)
    @my_report_id = report_id
  end
  
  def self.my_report_id
    @my_report_id || nil
  end

  def self.statuses
    self.get("/spaces/#{@current_space['id']}/tickets/custom_statuses", xml_headers)
  end

  def self.users
    self.get("/spaces/#{@current_space['id']}/users", xml_headers)
  end

  def self.milestones
    @statusses ||= get("/spaces/#{@current_space['id']}/milestones/", xml_headers)
  end
  
  def self.ticket= (id)
    @current_ticket = get("/spaces/#{@current_space['id']}/tickets/#{id}")['ticket']
  end

  def self.ticket
    @current_ticket
  end

  def self.tickets
    self.get("/spaces/#{@current_space['id']}/tickets/report/9", xml_headers)
  end

  def self.my_tickets
    get("/spaces/#{@current_space['id']}/tickets/custom_report/#{@my_report_id}", xml_headers)
  end

  def self.custom_reports
    get("/spaces/#{@current_space['id']}/custom_reports", xml_headers)
  end

  def self.custom_report (report_id)
    get("/spaces/#{@current_space['id']}/tickets/custom_report/#{report_id}", xml_headers)
  end
end
