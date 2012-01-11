require 'rubygems'
require 'irb'
require 'hirb'
require 'hashie'
require 'httparty'
require 'isna'
require 'yaml'
require 'highline/import'
require "assembla_cli/version"

module Assembla
  include HTTParty
  format :xml
  base_uri 'www.assembla.com'

  def self.reset!
    @current_space = @milestones = @my_report_id = @statuses, @users = nil
  end

  def self.xml_headers
   {:headers => {'Accept' => 'application/xml', 'Content-Type' => 'application/xml'}}
  end

  def self.setup_credentials
    login_name = ask('Username:')
    password   = ask('Password:') { |prompt| prompt.echo = false }
    [ login_name, password ]
  end

  def self.login (login_name, password)
    @login_name = login_name
    @password = password

    basic_auth(login_name, password)
  end

  def self.spaces
    get('/spaces/my_spaces', xml_headers)
  end

  def self.space (space_name = nil)
    if space_name
        @current_space = get("/spaces/#{space_name.gsub(/ /, '-').downcase}", xml_headers)
    end
    @current_space
  end

  def self.my_report_id (report_id = nil)
    if report_id
        @my_report_id = report_id
    end
    @my_report_id
  end

  def self.statuses
    @statuses ||= get("/spaces/#{space['space']['id']}/tickets/custom_statuses", xml_headers)
  end

  def self.users
    @users ||= get("/spaces/#{space['space']['id']}/users", xml_headers)
  end

  def self.milestones
    @milestones ||= get("/spaces/#{space['space']['id']}/milestones/", xml_headers)
  end
  
  def self.ticket (ticket_id = nil)
    if ticket_id
      @current_ticket = get("/spaces/#{space['space']['id']}/tickets/#{ticket_id}", xml_headers)
    end
    @current_ticket
  end

  def self.tickets
    get("/spaces/#{space['space']['id']}/tickets/report/3", xml_headers)
  end

  def self.my_tickets
    get("/spaces/#{space['space']['id']}/tickets/report/8", xml_headers)
  end

  def self.custom_reports
    get("/spaces/#{space['space']['id']}/custom_reports", xml_headers)
  end

  def self.custom_report (report_id)
    get("/spaces/#{space['space']['id']}/tickets/custom_report/#{report_id}", xml_headers)
  end
  
  def self.add_comment (comment)
    update_ticket("<ticket><user-comment>#{comment}</user-comment></ticket>")
  end

  def self.change_status (status_name)
    update_ticket("<ticket><status>#{status_name}</status></ticket>")
  end

  def self.update_ticket (body)
    put("/spaces/#{space['space']['id']}/tickets/#{ticket['ticket']['number']}", xml_headers.merge!(:body => "#{body}"))
  end
end
