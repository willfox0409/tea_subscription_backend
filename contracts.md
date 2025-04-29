# JSON Contracts

## API Endpoints

### Subscriptions

#### GET /api/v1/subscriptions

response body:

```json
{
  "data": [
    {
      "type": "subscription",
      "id": "1",
      "attributes": {
        "title": "Monthly Morning Mist",
        "price": 14.99,
        "status": "active",
        "frequency": "monthly",
      }
    },
     {
      "type": "subscription",
      "id": "2",
      "attributes": {
        "title": "Weekly Highland Chai Boost",
        "price": 9.99,
        "status": "active",
        "frequency": "weekly",
      }
    }
  ]
}
```

#### GET /api/v1/subscriptions/:id

response body:

```json
{
  "data": {
    "type": "subscription",
    "id": "1",
    "attributes": {
      "title": "Monthly Morning Mist",
      "price": 14.99,
      "status": "active",
      "frequency": "monthly",
      "customer": {
        "id": "3",
        "type": "customer",
        "attributes": {
          "first_name": "Brian",
          "last_name": "Eno",
          "email": "eno4eva@aol.com",
          "address": "14 Rose Street, Edinburgh, EH2 2QA"
        }
      },
      "tea": {
        "id": "2",
        "type": "tea",
        "attributes": {
          "title": "Foggy London Breakfast",
          "description": "Classic strong breakfast tea, a nod to London fog",
          "temperature": "210°F",
          "brew_time": "3 minutes"
        }
      }
    }
  }
}
```

#### PATCH /api/v1/subscriptions/:id

request body:

```json
{
  "subscription": {
    "status": "cancelled"
  }
}
```

response body:

```json

{
  "data": {
    "type": "subscription",
    "id": "1",
    "attributes": {
      "title": "Monthly Morning Mist",
      "price": 14.99,
      "status": "cancelled",
      "frequency": "monthly",
      "customer": {
        "id": "3",
        "type": "customer",
        "attributes": {
          "first_name": "Brian",
          "last_name": "Eno",
          "email": "eno4eva@aol.com",
          "address": "14 Rose Street, Edinburgh, EH2 2QA"
        }
      },
      "tea": {
        "id": "2",
        "type": "tea",
        "attributes": {
          "title": "Foggy London Breakfast",
          "description": "Classic strong breakfast tea, a nod to London fog",
          "temperature": "210°F",
          "brew_time": "3 minutes"
        }
      }
    }
  }
}
```


