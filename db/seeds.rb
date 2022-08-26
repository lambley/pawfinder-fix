require 'csv'

dog_csv = File.read(Rails.root.join('db','csv_seeds', 'dog.csv'))
park_csv = File.read(Rails.root.join('db','csv_seeds', 'park.csv'))
user_csv = File.read(Rails.root.join('db', 'csv_seeds', 'user.csv'))
restaurant_csv = File.read(Rails.root.join('db', 'csv_seeds', 'restaurant.csv'))

# USERS
p "creating users"
user_csv_data = CSV.parse(user_csv, headers: true, encoding: 'ISO-8859-1')
counter = 0
user_csv_data.each do |row|
  u = User.create!(
    first_name: row['first_name'],
    last_name: row['last_name'],
    biography: row['biography'],
    email: Faker::Internet.email,
    password: "123456"
  )
  u.location = Location.create(
    city: row["city"],
    postcode: row['city']
  )
  counter += 1 if u.persisted?
  print "."
end
p ""
p ">>> #{counter} #{'user'.pluralize(counter)} generated"

# DOGS
p "creating dogs"
dog_csv_data = CSV.parse(dog_csv, headers: true, encoding: 'ISO-8859-1')
counter = 0
user_increment = 1
dog_csv_data.each do |row|
  d = Dog.create!(
    name: row['name'],
    breed: row['breed'],
    colour: row['colour'],
    age: row['age'],
    biography: row['biography'],
    user_id: user_increment
  )
  counter += 1 if d.persisted?
  user_increment += 1
  print "."
end
p ""
p ">>> #{counter} #{'dog'.pluralize(counter)} generated"

# ACTIVITIES
p "creating activities - parks"
counter = 0
park_csv_data = CSV.parse(park_csv, headers: true, encoding: 'ISO-8859-1')
park_csv_data.each do |row|
  park = Activity.create!(
    name: row["name"],
    description: row["description"],
    category: row["category"],
    park_feature: row["park_feature"],
    user_id: 1
  )
  park.location = Location.create(
    street: row["street"],
    city: row["city"],
    postcode: row["postcode"]
  )
  counter += 1 if park.persisted?
  print "."
end
p ""

p "creating activities - restaurants"
restaurant_csv_data = CSV.parse(restaurant_csv, headers: true, encoding: 'ISO-8859-1')
restaurant_csv_data.each do |row|
  restaurant = Activity.create!(
    name: row['name'],
    description: row['description'],
    category: row['category'],
    restaurant_type: row['restaurant_type'],
    user_id: 1
  )
  # error handle failed location creation
  begin
    restaurant.location = Location.create(
      street: row["street"],
      city: row["city"],
      postcode: row["postcode"]
    )
  ensure
    restaurant.location = Location.all.sample unless restaurant.location.present?
    print "."
  end
  counter += 1 if restaurant.persisted?
end
p ""

p "creating activities - dog bins"
20.times do
  random_park = Activity.where(category: "park").sample
  bin = Activity.create!(
    name: "Dog Bin, #{random_park}",
    description: "A dog bin park in #{random_park}",
    category: "dog bin",
    user_id: 1
  )
  bin.location = random_park.location
  print "."
  counter += 1 if bin.persisted?
end
p ""
p ">>> #{counter} #{'activity'.pluralize(counter)} in total generated"

# REVIEWS
p "creating park reviews"
counter = 0
60.times do
  # park reviews
  random_park = Activity.where(category: "park").sample
  park_review = Review.create!(
    content: "#{random_park} - worth visiting!",
    rating: rand(1..10),
    user_id: User.ids.sample,
    activity_id: random_park.id
  )
  counter += 1 if park_review.persisted?
  # restaurant reviews
  random_restaurant = Activity.where(category: "restaurant").sample
  restaurant_review = Review.create!(
    content: "#{random_restaurant} - interesting menu!",
    rating: rand(1..10),
    user_id: User.ids.sample,
    activity_id: random_restaurant.id
  )
  counter += 1 if restaurant_review.persisted?
  # bin reviews
  random_bin = Activity.where(category: "restaurant").sample
  bin_review = Review.create!(
    content: "#{random_bin} - useful location!",
    rating: rand(1..10),
    user_id: User.ids.sample,
    activity_id: random_bin.id
  )
  counter += 1 if bin_review.persisted?
end
p ">>> #{counter} #{'review'.pluralize(counter)} generated"
