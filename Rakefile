# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

namespace :export do
  desc "Exports all tables with locations"
  task user: [:environment] do
    file = "#{Rails.root}/public/user_table.csv"
    table = User.all
    CSV.open(file, 'w') do |writer|
      # write attributes as column headers
      headers = table.first.attributes.map{ |a,v| a }
      headers << "street"
      headers << "city"
      headers << "postcode"
      headers << "longitude"
      headers << "latitude"
      writer << headers
      table.each do |p|
        arr = [
          p.id,
          p.email,
          p.encrypted_password,
          p.reset_password_token,
          p.reset_password_sent_at,
          p.remember_created_at,
          p.created_at,
          p.updated_at,
          p.first_name,
          p.last_name,
          p.biography
        ]
        unless p.location.nil?
          arr << p.location.street
          arr << p.location.city
          arr << p.location.postcode
          arr << p.location.longitude
          arr << p.location.latitude
        end
        writer << arr
      end
    end
  end
  desc "Exports all tables with locations"
  task activity: [:environment] do
    file = "#{Rails.root}/public/activity_table.csv"
    table = Activity.all
    CSV.open(file, 'w') do |writer|
      # write attributes as column headers
      headers = table.first.attributes.map{ |a,v| a }
      headers << "street"
      headers << "city"
      headers << "postcode"
      headers << "longitude"
      headers << "latitude"
      writer << headers
      table.each do |p|
        arr = [
          p.id,
          p.name,
          p.description,
          p.category,
          p.restaurant_type,
          p.park_feature,
          p.user_id,
          p.created_at,
          p.updated_at
        ]
        unless p.location.nil?
          arr << p.location.street
          arr << p.location.city
          arr << p.location.postcode
          arr << p.location.longitude
          arr << p.location.latitude
        end
        writer << arr
      end
    end
  end
end
