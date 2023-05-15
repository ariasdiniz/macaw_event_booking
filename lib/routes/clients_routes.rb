# frozen_string_literal: true

require_relative '../usecases/clients_handler'
require 'json'

class ClientsRoutes
  def self.set_clients_routes(macaw)
    signup(macaw)
    login(macaw)
    logoff(macaw)
  end

  def self.signup(macaw)
    macaw.post('/signup') do |context|
      body = JSON.parse(context[:body])
      raise 'The request body must have username and password fields' if body.nil?
      raise 'The request body must have a username field' if body['username'].nil?
      raise 'The request body must have a password field' if body['password'].nil?

      ClientsHandler.signup(body)
      return JSON.pretty_generate({ message: 'Client registered' }), 201, { 'Content-Type': 'application/json' }
    rescue StandardError => e
      return JSON.pretty_generate({ message: e.message }), 400, { 'Content-Type': 'application/json' }
    end
  end

  def self.login(macaw)
    macaw.post('/login') do |context|
      body = JSON.parse(context[:body])
      raise 'The request body must have username and password fields' if body.nil?
      raise 'The request body must have a username field' if body['username'].nil?
      raise 'The request body must have a password field' if body['password'].nil?

      ClientsHandler.login(body, context[:client])
      return JSON.pretty_generate({ message: 'Logged in' }), 200, { 'Content-Type': 'application/json' }
    rescue StandardError => e
      return JSON.pretty_generate({ message: e.message }), 400, { 'Content-Type': 'application/json' }
    end
  end

  def self.logoff(macaw)
    macaw.post('logoff') do |context|
      ClientsHandler.logoff(context[:client])
      return JSON.pretty_generate({ message: 'Logged off' }), 200, { 'Content-Type': 'application/json' }
    end
  end
end
