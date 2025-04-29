# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# CUSTOMERS

Customer.create!([
  {
    first_name: "Cate",
    last_name: "Le Bon", 
    email: "lebonbon@hotmail.com", 
    address: "23 Gower Road, Swansea SA2 9BZ"
  },
  {
    first_name: "John", 
    last_name: "Cale",
    email: "johnnycale@yahoo.com",
    address: "221B Baker Street, London, NW1 6XE"
  },
  {
    first_name: "Brian",
    last_name: "Eno",
    email: "eno4eva@aol.com",
    address: "14 Rose Street, Edinburgh, EH2 2QA"
  }
])

# TEAS

Tea.create!([
  {
    title: "Morning Mist",
    description: "Light and floral green tea perfect for early mornings",
    temperature: "175°F",
    brew_time: "3 minutes"
  },
  {
    title: "Foggy London Breakfast",
    description: "Classic strong breakfast tea, a nod to London fog",
    temperature: "210°F",
    brew_time: "3 minutes"
  },
  {
    title: "Highland Chai",
    description: "Spicy black tea blend inspired by the Scottish Highlands",
    temperature: "212°F",
    brew_time: "5 minutes"
  },
  {
    title: "Lavender Drift",
    description: "Calming herbal infusion with lavender and chamomile",
    temperature: "200°F",
    brew_time: "5 minutes"
  },
  {
    title: "Dragon's Breath",
    description: "Bold smoky lapsang souchong black tea",
    temperature: "212°F",
    brew_time: "4 minutes"
  },
  {
    title: "Elderflower Breeze",
    description: "Sweet white tea with elderflower and citrus notes",
    temperature: "185°F",
    brew_time: "3 minutes"
  },
  {
    title: "Hearthside Rooibos",
    description: "Rich, caffeine-free rooibos blend with vanilla and cinnamon",
    temperature: "200°F",
    brew_time: "6 minutes"
  }
])

# SUBSCRIPTIONS

customer1 = Customer.first
customer2 = Customer.second
customer3 = Customer.third

tea1 = Tea.find_by(title: "Morning Mist")
tea2 = Tea.find_by(title: "Highland Chai")
tea3 = Tea.find_by(title: "Lavender Drift")
tea4 = Tea.find_by(title: "Dragon's Breath")
tea5 = Tea.find_by(title: "Foggy London Breakfast")
tea6 = Tea.find_by(title: "Hearthside Rooibos")

Subscription.create!([
  {
    title: "Monthly Morning Mist",
    price: 14.99,
    status: "active",
    frequency: "monthly",
    customer: customer1,
    tea: tea1
  },
  {
    title: "Weekly Highland Chai Boost",
    price: 9.99,
    status: "active",
    frequency: "weekly",
    customer: customer1,
    tea: tea2
  },
  {
    title: "Evening Lavender Calm",
    price: 12.99,
    status: "cancelled",
    frequency: "monthly",
    customer: customer2,
    tea: tea3
  },
  {
    title: "Dragon's Breath Sampler",
    price: 15.49,
    status: "active",
    frequency: "monthly",
    customer: customer2,
    tea: tea4
  },
  {
    title: "Abbey Road Break Room",
    price: 13.99,
    status: "active",
    frequency: "quarterly",
    customer: customer3,
    tea: tea5
  },
  {
    title: "Winter Rooibos Warmer",
    price: 11.49,
    status: "active",
    frequency: "monthly",
    customer: customer3,
    tea: tea6
  }
])

puts "Seeded Successfully!"