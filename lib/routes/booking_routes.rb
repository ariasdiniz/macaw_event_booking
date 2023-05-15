# frozen_string_literal: true

require_relative '../usecases/bookings_handler'
require 'json'

class BookingRoutes

  def self.set_booking_routes(macaw)
    book_event(macaw)
    get_all_bookings(macaw)
  end

  def self.book_event(macaw)
    macaw.post('/bookings') do |context|
      name = JSON.parse(context[:body])
      raise 'The "name" of the event cannot be null.' if name.nil?

      BookingsHandler.book_ticket(context[:client], name['name'])
      return JSON.pretty_generate({ message: 'Event booked with success' }), 200, { 'Content-Type': 'application.json' }
    rescue StandardError => e
      return JSON.pretty_generate({ message: e.message }), 400, { 'Content-Type': 'application.json' }
    end
  end

  def self.get_all_bookings(macaw)
    macaw.get('/booking') do |_context|
      return JSON.pretty_generate(JSON.pretty_generate(BookingsHandler.get_all_bookings)), 200, { 'Content-Type': 'application.json' }
    rescue StandardError => e
      return JSON.pretty_generate({ message: e.message }), 400, { 'Content-Type': 'application.json' }
    end
  end
end
