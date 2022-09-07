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
    password: "123456",
    cl_tag: row['cl_tag']
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
    cl_tag: row['cl_tag'],
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
    cl_tag: row["cl_tag"],
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
  random_park_reviews = [
    "worth visiting #{random_park.name}!",
    "#{random_park.name} - worth visiting!",
    "one of the best parks in the area",
    "#{random_park.name} is dog friendly and very clean",
    "great afternoon walk location",
    "definitely worth visiting #{random_park.name}",
    "#{random_park.name} has lots of shade on those hotter days",
    "a park with lots to see",
    "lots to do round #{random_park.name}",
    "#{random_park.name} - highly recommended",
    "not sure if I would come back to #{random_park.name}",
    "#{random_park.name} could be a better",
    "#{random_park.name} could be worse"
  ]
  park_review = Review.create!(
    content: random_park_reviews.sample,
    rating: rand(1..10),
    user_id: User.ids.sample,
    activity_id: random_park.id
  )
  print "."
  counter += 1 if park_review.persisted?

  # restaurant reviews
  random_restaurant = Activity.where(category: "restaurant").sample
  random_restaurant_reviews = [
    "worth visiting #{random_restaurant.name}!",
    "#{random_restaurant.name} - worth visiting!",
    "one of the best restaurants in the area",
    "#{random_restaurant.name} is dog friendly and very clean",
    "great spot for an evening meal with friends",
    "definitely worth visiting #{random_restaurant.name}",
    "#{random_restaurant.name} has a great menu",
    "#{random_restaurant.name} has a cheap menu with lots to choose from",
    "a restaunrt with lots of variety",
    "great atmosphere in #{random_restaurant.name}",
    "#{random_restaurant.name} - highly recommended",
    "not sure if I would come back to #{random_restaurant.name}",
    "#{random_restaurant.name} could be a better",
    "#{random_restaurant.name} could be worse"
  ]
  restaurant_review = Review.create!(
    content: random_restaurant_reviews.sample,
    rating: rand(1..10),
    user_id: User.ids.sample,
    activity_id: random_restaurant.id
  )
  print "."
  counter += 1 if restaurant_review.persisted?

  # bin reviews
  random_bin = Activity.where(category: "dog bin").sample
  random_bin_reviews = [
    "worth visiting #{random_bin.name}!",
    "#{random_bin.name} - worth visiting!",
    "one of the best restaurants in the area",
    "#{random_bin.name} is dog friendly and very clean",
    "great spot for an evening meal with friends",
    "definitely worth visiting #{random_bin.name}",
    "#{random_bin.name} has a great menu",
    "#{random_bin.name} has a cheap menu with lots to choose from",
    "a restaunrt with lots of variety",
    "great atmosphere in #{random_bin.name}",
    "#{random_bin.name} - highly recommended",
    "not sure if I would come back to #{random_bin.name}",
    "#{random_bin.name} could be a better",
    "#{random_bin.name} could be worse"
  ]
  bin_review = Review.create!(
    content: random_bin_reviews.sample,
    rating: rand(1..10),
    user_id: User.ids.sample,
    activity_id: random_bin.id
  )
  print "."
  counter += 1 if bin_review.persisted?
end
p ""
p ">>> #{counter} #{'review'.pluralize(counter)} generated"

p "Generating random favourites"

10.times do
  User.last.favourites << Favourite.create(favouritable: Activity.all.sample)
  print "."
end

50.times do
  User.all.sample.favourites << Favourite.create(favouritable: Activity.all.sample)
  print "."
end
