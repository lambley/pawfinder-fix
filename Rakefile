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
      writer << table.first.attributes.map{ |a,v| a }
      table.each do |p|
        # write each attribute value to file
        writer << p.attributes.map{ |a,v| v }
      end
    end
  end
end
