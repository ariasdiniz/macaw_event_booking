# frozen_string_literal: true

require_relative '../models/bookings'
require_relative '../models/clients'
require_relative '../usecases/events_handler'

class BookingsHandler
  def self.book_ticket(session, event_name)
    EventsHandler.book_ticket(event_name)
    Bookings.create(username: session[:login], event_name: event_name)
  end

  def self.get_all_bookings
    Bookings.all.as_json
  end

  def self.get_bookings_by_id(id)
    Bookings.where(id: id)
  end
end
