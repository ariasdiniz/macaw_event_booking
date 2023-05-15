# frozen_string_literal: true

require_relative 'usecases/events_handler'
require_relative 'routes/bookings_routes'
require_relative 'routes/events_routes'
require_relative 'routes/clients_routes'
require 'macaw_framework'
require 'active_record'
require 'yaml'
require 'json'

db_config = File.open('../db/database.yaml')
ActiveRecord::Base.establish_connection(YAML.safe_load(db_config, aliases: true))

m = MacawFramework::Macaw.new

EventsRoutes.set_events_routes(m)
BookingsRoutes.set_booking_routes(m)
ClientsRoutes.set_clients_routes(m)

m.start!
