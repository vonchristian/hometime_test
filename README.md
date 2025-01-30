# Hometime API Project

This project is a Ruby on Rails API application designed to handle and parse two distinct payload formats. The parsed data is saved to a `Reservation` model that belongs to a `Guest` model, ensuring that the `email` field for `Guest` is unique.

## Features
- Pure API-only Rails application.
- Single endpoint capable of handling two payload formats without additional headers or parameters.
- Validation and storage of payload data into the `Reservation`, `Pricing`, and `Guest` models.
- Service to normalize payloads (easily extendable to support new payload formats).
- Pricing model to store reservation pricing details (can be extended to include discounts, taxes, and other computations).
- Phone numbers are normalized to the E.164 format, which includes the country code and ensures the number is properly formatted for Twilio integration.
- Comprehensive unit and request specs to ensure application reliability.

## Requirements
- Ruby 3.3.5
- Rails 8.x
- PostgreSQL 15.x

## Setup Instructions

1. **Clone the Repository**

   ```bash
   git clone https://github.com/vonchristian/hometime_test.git
   cd hometime_test
   ```

2. **Install Dependencies**

   Ensure you have the required Ruby and Rails versions installed. Then, install the gems:

   ```bash
   bundle install
   ```

3. **Setup the Database**

   Create and migrate the database:

   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Run the Rails Server**

   Start the development server:

   ```bash
   bin/dev
   ```

   The API will be accessible at `http://localhost:3000`.

## API Endpoint

### URL
`POST /api/v1/reservations`

### Payloads

The endpoint accepts two payload formats:

**Payload Format 1:**
```json
{
  "start_date": "2021-03-12",
  "end_date": "2021-03-16",
  "nights": 4,
  "guests": 4,
  "adults": 2,
  "children": 2,
  "infants": 0,
  "status": "accepted",
  "guest": {
    "id": 1,
    "first_name": "Wayne",
    "last_name": "Woodbridge",
    "phone": "639123456789",
    "email": "wayne_woodbridge@bnb.com"
  },
  "currency": "AUD",
  "payout_price": "3800.00",
  "security_price": "500",
  "total_price": "4500.00"
}

```

**Payload Format 2:**
```json
{
  "reservation": {
    "start_date": "2021-03-12",
    "end_date": "2021-03-16",
    "expected_payout_amount": "3800.00",
    "guest_details": {
      "localized_description": "4 guests",
      "number_of_adults": 2,
      "number_of_children": 2,
      "number_of_infants": 0
    },
    "guest_email": "wayne_woodbridge@bnb.com",
    "guest_first_name": "Wayne",
    "guest_id": 1,
    "guest_last_name": "Woodbridge",
    "guest_phone_numbers": [
      "639123456789",
      "639123456789"
    ],
    "listing_security_price_accurate": "500.00",
    "host_currency": "AUD",
    "nights": 4,
    "number_of_guests": 4,
    "status_type": "accepted",
    "total_paid_amount_accurate": "4500.00"
  }
}

```

### Response
The endpoint will return:

- `201 Created` if the payload is successfully processed.
- `422 Unprocessable Entity` if there are validation errors.

## Testing

Run the test suite to ensure everything is working correctly:

```bash
rails spec
```

The test suite includes:
- **Unit tests** for services, models, and utility classes (e.g., payload normalization).
- **Request specs** to validate the API endpoint functionality.

