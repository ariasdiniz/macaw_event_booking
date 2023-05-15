# Macaw Event Booking App

This application is a demonstration of the capabilities of the Macaw Framework. It is an event booking platform with support for user login, signup, event creation, and ticket booking. The application is for learning purposes and comes preconfigured with an example SQLite3 database. To ensure safety, even in this study-purpose app, password hashing is used.

## About the Macaw Framework

The Macaw Framework is designed to be simple, performant, and easy to configure. The key idea is to eliminate the need to learn a complex Domain Specific Language (DSL), allowing developers to configure their web applications with just a few lines of code.

## Features

This Event Booking App showcases the following endpoints:

- **User Registration (`/signup`):** New users can sign up for an account.
- **User Login (`/login`):** Users can log into their account.
- **User Logoff (`/logoff`):** Users can log off from their account.
- **Event Creation (`/events`):** Users can create new events.
- **View Events (`/events`):** Users can view all events or specific events by name.
- **Ticket Booking (`/bookings`):** Users can book tickets for available events.
- **View Bookings (`/bookings`):** Users can view all bookings.

## Getting Started

### Prerequisites

To run this application, you'll need to have the following installed:

- Ruby (>= 2.7)
- Bundler

### Installation

1. Clone the repository:

```
git clone https://github.com/ariasdiniz/macaw_event_booking.git
```

2. Navigate into the project directory:

```
cd macaw_event_booking
```

3. Install the dependencies:

```
bundle install
```

4. The application comes preconfigured with an example SQLite3 database for learning purposes. No additional database setup is necessary.

5. Go inside the `/lib`folder and run the application:

```
cd lib
ruby main.rb
```

## Development

The application is divided into three main parts:

- **Main file (`main.rb`):** This is where the application is initialized and the routes are set.
- **Routes:** The application's routing logic is located in the `routes` directory. Each file in this directory corresponds to a set of related routes (e.g., `bookings_routes.rb`, `events_routes.rb`, `clients_routes.rb`).
- **Usecases (Business Logic):** The business logic of the application is encapsulated in "usecase" objects located in the `usecases` directory.

The application uses the Macaw Framework to handle incoming HTTP requests and the ActiveRecord ORM to interact with the database. The responses are in JSON format.

## Handlers

The application's logic is handled by three main components: `BookingsHandler`, `ClientsHandler`, and `EventsHandler`.

- **BookingsHandler:** This module is responsible for managing event bookings. It provides methods to book a ticket, retrieve all bookings, and get a specific booking by its ID.
- **ClientsHandler:** This module is responsible for handling the user accounts. It provides methods to check the client's status, sign up a new user, login, and log off. To ensure safety, password hashing is used when storing and verifying user passwords.
- **EventsHandler:** This module is responsible for managing events. It provides methods to register a new event, retrieve all events, get a specific event by name, and book a ticket for an event.

The handler modules interact with the models to perform these operations and maintain the business logic of the application.

## Models

The application has three models corresponding to the three main components:

- **Bookings:** Represents a booking made by a client for an event. It connects the Clients and Events models.
- **Clients:** Represents a user account. Stores the username and hashed password of the client.
- **Events:** Represents an event that can be booked by clients. Stores the name, date, and ticket information of the event.

These models use ActiveRecord ORM for database operations, providing a high-level API to interact with the underlying SQLite database.

## Contributing

As this is a showcase application, we're not currently accepting contributions. However, feel free to study the code and make your own versions!
