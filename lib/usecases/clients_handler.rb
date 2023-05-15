# frozen_string_literal: true

require_relative '../models/clients'
require 'digest'

class ClientsHandler
  def self.check_client_status(session)
    session[:login].nil? ? (return true) : (return false)
  end

  def self.signup(body)
    raise 'Client already exists' if Clients.find_by(username: body['username'])

    pswd = Digest::SHA2.hexdigest(body['password'])
    Clients.create(username: body['username'], password: pswd)
  end

  def self.login(body, session)
    pswd = body['password']
    user = Clients.find_by[username: body['username']]
    raise 'User not found' if user.nil?
    raise 'Incorrect Password!' unless Digest::SHA2.hexdigest(pswd) == user.password

    session[:login] = user.username
  end

  def self.logoff(session)
    session[:login] = nil
  end
end
