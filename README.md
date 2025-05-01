# README

> ⚙️ This is the **backend** repo for the Rock & Brew: Legendary Tea Subscriptions project.  
It includes all Rails API logic, database schema, serializers, and request specs.  
The full project (including frontend documentation and screenshots) is documented below.

# 🍵 Rock & Brew: Legendary Tea Subscriptions

A full-stack admin portal for managing tea subscriptions, built with a Rails API backend and a React frontend. This project was completed as a solo assessment over 3 days, following MVP principles and RESTful best practices.

---

## 📁 Project Structure

**Backend**: Ruby on Rails API  
**Frontend**: React (Vite + React Router DOM)  
**Testing**: RSpec (BE), Cypress (FE)  
**Database**: PostgreSQL  
**Documentation**: JSON:API-style contracts, Postman collection

---

## 📌 MVP Features

### Backend API

- Full CRUD functionality for subscriptions (GET, PATCH)
- Nested data relationships between Subscriptions, Customers, and Teas
- Filter endpoint for `/subscriptions?status=`
- JSON:API-compliant serialization
- Custom error handling via `rescue_from`
- Model-level scope: `Subscription.with_status(status)`
- Postman collection built to test and validate endpoints

### Schema from dbdiagram.io
<img width="770" alt="schema" src="https://github.com/user-attachments/assets/6d14be7f-3d15-41e8-aa3b-c73f51165571" />

### Joins Table (Subscriptions) from Postico
![Postico Screenshot of Joins Table](https://github.com/user-attachments/assets/917be84e-4892-4744-b736-263bab938469)


### Frontend

- Home page shows all Subscriptions with name, status, frequency, and mapped image
- Subscriptions are filterable by `active`, `cancelled`, or `all`
- Clicking “View Details” shows full tea & customer data
- `Teas` and `Customers` pages display lists (with images for teas)
- Local image mapping for both Subscriptions and Teas
- Fully responsive layout, tested across screen sizes

### Homepage (Subscriptions with filter Dropdown Menu)
![Homepage Mobile](https://github.com/user-attachments/assets/f55560f8-01a8-471a-ad0d-bb1d39081890)

### Subscription Details Page (with corresponding Customer and Tea)
![Subscription Details Page Mobile ](https://github.com/user-attachments/assets/97c51f75-e4ae-4ee4-8978-baa00d569012)

### Teas Offered
![Tea List Mobile](https://github.com/user-attachments/assets/67b6833b-d450-4fea-949e-6bc1d5dc89f2)

### Subscribers List
![Customers View Page mobile](https://github.com/user-attachments/assets/133c1a7c-5efa-44c5-be91-44ecc538f79d)

---

## 🧠 Planning & Architecture

### Component Tree

- `App` (Router & Nav)
  - `SubscriptionList`
    - `SubscriptionCard`
  - `SubscriptionDetails`
  - `CustomersView`
  - `TeasView`
 
### Component Architecture Diagram
![FE Component Architecture](https://github.com/user-attachments/assets/ed933c26-bd61-489f-aab4-cee145c01495)

### Design Decisions

- **Asset Mapping**: Tea and Subscription images are stored locally and mapped using JS objects based on title strings.
- **No Auth**: Since this is an internal admin tool, authentication was not included.
- **Responsiveness**: Simple flex/grid layout supports clean display across screen sizes.
- **Error Handling**: Custom 404, 400, and 422 JSON responses from Rails.

![BE MVP Prep](https://github.com/user-attachments/assets/08d8e888-4bde-45e6-8d4d-b6b6f255ea90)

---

## 🧪 Testing

### Backend

- 100% SimpleCov line coverage
- RSpec request and model specs:
  - Happy paths
  - Sad paths (invalid params, not found, invalid status)
- Postman collection for manual endpoint validation

### Frontend

- Cypress e2e tests for:
  - Home page rendering
  - Navigation to details page
  - Customers and Teas view rendering
- Tests are basic, and do not currently include sad path or network error simulation

---

## 🧭 Routes Overview

### Backend Routes

- GET    /api/v1/subscriptions
- GET    /api/v1/subscriptions/:id
- PATCH  /api/v1/subscriptions/:id
- GET    /api/v1/teas
- GET    /api/v1/customers

### Frontend Routes

- /                         → SubscriptionList
- /subscriptions/:id        → SubscriptionDetails
- /teas                     → TeasView
- /customers                → CustomersView

## 🗂 Tools Used

- Rails 7
- React
- Vite
- PostgreSQL
- Cypress
- RSpec
- Excalidraw
- dbdiagram.io
- Postman
- Postico

## ✅ Setup & Testing

### Backend (Rails API)

To set up and run the backend:

```bash
bundle install
rails db:{drop,create,migrate,seed}
rails s
```

To run the test suite and check code coverage:
```
bundle exec rspec
open coverage/index.html  
```

### Frontend (React)

To set up and run the frontend:
```
npm install
npm run dev
```
To run Cypress end-to-end tests:
```
npx cypress open
```

