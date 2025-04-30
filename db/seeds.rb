puts "🌱 Clearing old data..."

Subscription.destroy_all
Tea.destroy_all
Customer.destroy_all

puts "🌱 Old data cleared!"

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
  },
  {
    first_name: "Debbie",
    last_name: "Harry",
    email: "debbie@blondie.com",
    address: "123 Parallel Lines, NYC"
  },
  {
    first_name: "Jimi",
    last_name: "Hendrix",
    email: "jimi@purplehaze.org",
    address: "420 Electric Lady Studios, Seattle"
  },
  {
    first_name: "Robert",
    last_name: "Plant",
    email: "stairway@heaven.co.uk",
    address: "Led Zeppelin Lane, Birmingham"
  },
  {
    first_name: "Stevie",
    last_name: "Nicks",
    email: "stevie@dreams.fm",
    address: "Rhiannon Road, Los Angeles"
  },
  {
    first_name: "David",
    last_name: "Bowie",
    email: "ziggy@stardust.com",
    address: "Starman St, London"
  },
  {
    first_name: "Mick",
    last_name: "Fleetwood",
    email: "rumours@mac.co.uk",
    address: "Tusk Trail, Los Angeles"
  },
  {
    first_name: "George",
    last_name: "Harrison",
    email: "quietbeatle@apple.com",
    address: "Blue Jay Way, LA"
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
customers = Customer.all
teas = Tea.all

Subscription.create!([
  {
    title: "Bowie Blast",
    price: 14.99,
    status: "active",
    frequency: "monthly",
    customer: customers[0],
    tea: teas.find { |t| t.title == "Morning Mist" }
  },
  {
    title: "Green Haze",
    price: 9.99,
    status: "active",
    frequency: "weekly",
    customer: customers[1],
    tea: teas.find { |t| t.title == "Highland Chai" }
  },
  {
    title: "Dreamy Drift",
    price: 12.99,
    status: "cancelled",
    frequency: "monthly",
    customer: customers[2],
    tea: teas.find { |t| t.title == "Lavender Drift" }
  },
  {
    title: "Smoke on the Water",
    price: 15.49,
    status: "active",
    frequency: "monthly",
    customer: customers[3],
    tea: teas.find { |t| t.title == "Dragon's Breath" }
  },
  {
    title: "Abbey Road Break Room",
    price: 13.99,
    status: "active",
    frequency: "quarterly",
    customer: customers[4],
    tea: teas.find { |t| t.title == "Foggy London Breakfast" }
  },
  {
    title: "Fleetwood Fresh",
    price: 11.49,
    status: "active",
    frequency: "monthly",
    customer: customers[5],
    tea: teas.find { |t| t.title == "Hearthside Rooibos" }
  },
  {
    title: "Green Haze",
    price: 9.99,
    status: "cancelled",
    frequency: "weekly",
    customer: customers[6],
    tea: teas.find { |t| t.title == "Morning Mist" }
  },
  {
    title: "Bowie Blast",
    price: 14.99,
    status: "active",
    frequency: "monthly",
    customer: customers[7],
    tea: teas.find { |t| t.title == "Morning Mist" }
  },
  {
    title: "Fleetwood Fresh",
    price: 11.49,
    status: "cancelled",
    frequency: "monthly",
    customer: customers[8],
    tea: teas.find { |t| t.title == "Hearthside Rooibos" }
  },
  {
    title: "Abbey Road Break Room",
    price: 13.99,
    status: "active",
    frequency: "weekly",
    customer: customers[9],
    tea: teas.find { |t| t.title == "Foggy London Breakfast" }
  }
])

puts "🎸 Seeded with classic rock subscriptions!"