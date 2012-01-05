require 'rubygems'
require 'hirb'
require 'hashie'
require 'httparty'
require 'isna'

class Assembla
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

  def self.statuses
    self.get("/spaces/#{@current_space['id']}/tickets/custom_statuses", xml_headers)
  end

  def self.users
    self.get("/spaces/#{@current_space['id']}/users", xml_headers)
  end

  def self.milestones
    get("/spaces/#{@current_space['id']}/milestones/", xml_headers)
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

require 'init'

extend Hirb::Console

# Statuses dont change a log, so keep them cached to make ticket
# listing faster.
def status_translations
  @status_translations ||= Assembla.statuses['ticket_statuses']
end

def milestone_translation
  @milestone_translation ||= Assembla.milestones['milestones']
end

def clean_cache
  @milestone_translation
  @status_translations
end

# Translates a status-id into its status-name equivalent.
def status_string number
  status_translations.each do |hash|
    if hash['list_order'] == number
      return hash['name']
    end
  end
  'Unknown'
end

# Translates a milestone-id into its milestone-name equivalent.
def milestone_string number
  milestone_translation.each do |hash|
    if hash['id'] == number
      return hash['title']
    end
  end
  'Unknown'
end

def tickets
  # Prepare table data.
  headers = ['number', 'priority', 'milestone_id', 'status_name', 'summary']
  hash    = Assembla.my_tickets['tickets']

  # Replace status numbers for status strings
  # TODO: we might need to send data so overriding is not cool.
  # So maybe we should manage translations differently.
  hash.each { |row| row['priority'] = status_string(row['priority']) }
  hash.each { |row| row['milestone_id'] = milestone_string(row['milestone_id']) }

  # Print data
  table = Hirb::Helpers::AutoTable.render(hash, :fields => headers)
  c = :green
  table.each_line do |line|
    c = c == :green ? :yellow : :green
    puts line.chomp.to_ansi.send(c)
  end
  # TODO: Think on how this can be handled better.
  # clean_cache
  nil
end

def milestones
  table Assembla.milestones['milestones'], :fields => ['id', 'title']
end

def open (ticket_id)
  `open https://www.assembla.com/spaces/breezi/tickets/#{ticket_id}`
  nil
end
