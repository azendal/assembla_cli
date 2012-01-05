require 'rubygems'
require 'httparty'

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

  def self.users
    self.get("/spaces/#{@current_space['id']}/users", xml_headers)
  end
  
  def self.tickets
    self.get("/spaces/#{@current_space['id']}/tickets", xml_headers)
  end
end
