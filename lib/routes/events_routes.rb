# frozen_string_literal: true

require_relative '../usecases/events_handler'
require 'json'

module EventsRoutes
  def self.set_events_routes(macaw)
    create_new_event(macaw)
    get_all_events(macaw)
  end

  def self.create_new_event(macaw)
    macaw.post('/events') do |context|
      event = JSON.parse(context[:body])
      raise 'Field "name" is mandatory' if event['name'].nil?
      raise 'Field "date" is mandatory' if event['date'].nil?
      raise 'Field "total_tickets" is mandatory' if event['total_tickets'].nil?

      EventsHandler.register_new_event(event)
      return JSON.pretty_generate({ message: 'Event registered successfully' }), 201, { 'Content-Type': 'application.json' }
    rescue StandardError => e
      return JSON.pretty_generate({ message: e.message }), 400, { 'Content-Type': 'application.json' }
    end
  end

  def self.get_all_events(macaw)
    macaw.get('/events') do |context|
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
  end
end
