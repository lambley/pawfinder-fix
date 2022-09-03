require 'csv'

dog_csv = File.read(Rails.root.join('db', 'csv_seeds', 'dog.csv'))
user_csv = File.read(Rails.root.join('db', 'csv_seeds', 'user.csv'))
activity_csv = File.read(Rails.root.join('db', 'csv_seeds', 'activity.csv'))

# USERS
p "creating users"
user_csv_data = CSV.parse(user_csv, headers: true, encoding: 'ISO-8859-1')
counter = 0
user_csv_data.each do |row|
  u = User.create!(
    first_name: row['first_name'],
    last_name: row['last_name'],
    biography: row['biography'],
    email: row['email'],
    password: "123456"
  )
  u.location = Location.create(
    street: row["street"],
    city: row["city"],
    postcode: row['postcode'],
    longitude: row['longitude'],
    latitude: row['latitude']
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
p "creating activities"
counter = 0
activity_csv_data = CSV.parse(activity_csv, headers: true, encoding: 'ISO-8859-1')
activity_csv_data.each do |row|
  a = Activity.create!(
    name: row["name"],
    description: row["description"],
    category: row["category"],
    park_feature: row["park_feature"],
    restaurant_type: row["restaurant_type"],
    user_id: 1
  )
  a.location = Location.create(
    street: row["street"],
    city: row["city"],
    postcode: row["postcode"],
    longitude: row["longitude"],
    latitude: row["latitude"]
  )
  counter += 1 if a.persisted?
  print "."
end
p ""

p ">>> #{counter} #{'activity'.pluralize(counter)} in total generated"

# REVIEWS
counter = 0
p "creating reviews"
180.times do
  # park reviews
  random_park = Activity.where(category: "park").sample
  park_review = Review.create!(
    content: "#{random_park.name} - worth visiting!",
    rating: rand(1..10),
    user_id: User.ids.sample,
    activity_id: random_park.id
  )
  print "."
  counter += 1 if park_review.persisted?
  # restaurant reviews
  random_restaurant = Activity.where(category: "restaurant").sample
  restaurant_review = Review.create!(
    content: "#{random_restaurant.name} - interesting menu!",
    rating: rand(1..10),
    user_id: User.ids.sample,
    activity_id: random_restaurant.id
  )
  print "."
  counter += 1 if restaurant_review.persisted?
  # bin reviews
  random_bin = Activity.where(category: "dog bin").sample
  bin_review = Review.create!(
    content: "#{random_bin.name} - useful location!",
    rating: rand(1..10),
    user_id: User.ids.sample,
    activity_id: random_bin.id
  )
  print "."
  counter += 1 if bin_review.persisted?
end
p ""
p ">>> #{counter} #{'review'.pluralize(counter)} generated"
