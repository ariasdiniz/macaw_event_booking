# frozen_string_literal: true

require_relative '../models/events'

module EventsHandler
  @mutex = Mutex.new

  def self.register_new_event(event)
    raise 'Event already exists!' unless check_events_by_name(event['name']).nil?

    Events.create!(
      name: event['name'],
      date: event['date'],
      total_tickets: event['total_tickets'].to_i,
      current_tickets: event['total_tickets'].to_i
    )
  end

  def self.check_events
    Events.all.as_json
  end

  def self.check_events_by_name(event_name)
    Events.find_by(name: event_name.gsub('%20', ' '))
  end

  def self.book_ticket(event_name)
    @mutex.synchronize do
      event = check_events_by_name(event_name)
      raise "Event with name #{event.name} does not exist" if event.nil?
      raise 'No more available tickets for this event' if event.current_tickets.to_i.zero?

      current_tickets = event.current_tickets - 1

      event.update_attribute('current_tickets', current_tickets)
    end
  end
end
