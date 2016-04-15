# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create(email: 'shoutsid@gmail.com', password: 'password', password_confirmation: 'password')

puts ENV["GCM_AUTH_KEY"]
raise "GCM key not provided" if ENV["GCM_AUTH_KEY"] == nil
app = Rpush::Gcm::App.find_or_create_by(name: 'goforus_android', auth_key: ENV["GCM_AUTH_KEY"], connections: 1)
