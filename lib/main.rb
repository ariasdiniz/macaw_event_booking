# frozen_string_literal: true

require_relative 'usecases/events_handler'
require 'macaw_framework'
require 'active_record'
require 'yaml'
require 'json'

db_config = File.open('../db/database.yaml')
ActiveRecord::Base.establish_connection(YAML.safe_load(db_config, aliases: true))

m = MacawFramework::Macaw.new

m.post('/events') do |context|
  event = JSON.parse(context[:body])
  raise 'Field "name" is mandatory' if event['name'].nil?
  raise 'Field "date" is mandatory' if event['date'].nil?
  raise 'Field "total_tickets" is mandatory' if event['total_tickets'].nil?

  EventsHandler.register_new_event(event)
  return JSON.pretty_generate({ message: 'Event registered successfully' }), 201, { 'Content-Type': 'application.json' }
rescue StandardError => e
  return JSON.pretty_generate({ message: e.message }), 400, { 'Content-Type': 'application.json' }
end

m.get('/events') do |context|
  if context[:params]['name'].nil?
    return JSON.pretty_generate(EventsHandler.check_events), 200, { 'Content-Type': 'application.json' }
  else
    return JSON.pretty_generate(EventsHandler.check_events_by_name(context[:params]['name']).as_json),
      200,
      { 'Content-Type': 'application.json' }
  end
rescue StandardError
  return JSON.pretty_generate({ message: 'Error recovering events' }), 500, { 'Content-Type': 'application.json' }
end

m.post('/booking') do |context|
  name = JSON.parse(context[:body])
  raise 'The "name" of the event cannot be null.' if name.nil?

  EventsHandler.book_ticket(name['name'])
  return JSON.pretty_generate({ message: 'Event booked with success' }), 200, { 'Content-Type': 'application.json' }
rescue StandardError => e
  return JSON.pretty_generate({ message: e.message }), 400, { 'Content-Type': 'application.json' }
end

m.start!
