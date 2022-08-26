require 'open-uri'
require 'csv'

dog_csv = File.read(Rails.root.join('db','csv_seeds', 'dog.csv'))
park_csv = File.read(Rails.root.join('db','csv_seeds', 'park.csv'))
user_csv = File.read(Rails.root.join('db', 'csv_seeds', 'user.csv'))
user_csv_data = CSV.parse(user_csv, headers: true, encoding: 'ISO-8859-1')
dog_csv_data = CSV.parse(dog_csv, headers: true, encoding: 'ISO-8859-1')
park_csv_data = CSV.parse(park_csv, headers: true, encoding: 'ISO-8859-1')

def download(csv_data, file)
  counter = 1
  csv_data.each do |row|
    begin
      IO.copy_stream(URI.open(row['image_url']), "#{Rails.root}/app/assets/images/#{file}_#{counter}.jpg")
    rescue => exception
      p "could not download file for dog id #{counter}"
      next
    ensure
      counter += 1
    end
  end
end

download(dog_csv_data, "dog")
download(user_csv_data, "user")
download(park_csv_data, "park")
