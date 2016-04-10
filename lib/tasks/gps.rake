require_relative '../simulator.rb'

namespace :gps do
  desc ""
  task simulator: :environment do |t, args|
    drivers = []
    driver1 = Partner.find_by(email: 'tim_westwood@example.com')
    driver1 = Partner.create!(name: 'Tim Westwood', email: 'tim_westwood@example.com', password: 'password') unless driver1
    driver1.online = true
    driver1.available = true
    driver1.save
    unless (driver1.vehicles.count > 0)
      driver1.vehicles.create!(registration: 'WESTY WOOD', make: 'Vauxhall', model: 'Vectra XR', vehicle_type: "Standard Car", online_with: true)
    end
    drivers << driver1

    driver2 = Partner.find_by(email: 'partner@test.com')
    driver2 = Partner.create!(name: 'James Summerill', email: 'partner@test.com', password: 'password') unless driver2
    driver2.online = true
    driver2.available = false
    driver2.save
    unless (driver2.vehicles.count > 0)
      driver2.vehicles.create!(registration: 'Go4Us App V1', make: 'BMW', model: 'i8', vehicle_type: "Standard Car", online_with: true)
    end
    drivers << driver2

    driver3 = Partner.find_by(email: 'victoria_summerill@example.com')
    driver3 = Partner.create!(name: 'Victoria Summerill', email: 'victoria_summerill@example.com', password: 'password') unless driver3
    driver3.online = false
    driver3.available = false
    driver3.save
    unless (driver3.vehicles.count > 0)
      driver3.vehicles.create!(registration: 'TrickyVicky', make: 'Tommy Moped', model: 'DB125T', vehicle_type: "Scooter", online_with: true)
    end
    drivers << driver3

    gpx = Gpx = GPX::GPXFile.new(gpx_file: File.join(File.dirname(__FILE__), "../../gpx_files/routes.gpx"))
    threads = []

    drivers.each do |driver|
      threads << Thread.new  {
        while(true) do
          gpx.tracks.each do |track|
            p track.moving_duration

            steps = []
            track.segments.each do |segment|
              segment.points.each_with_index { |w, i|
                next_point = segment.points[i + 1]
                time_to_wait = if next_point
                                 next_point.time.to_f - w.time.to_f
                               else
                                 1
                               end
                steps << { lat: w.lat, lng: w.lon, wait: time_to_wait }
              }
            end


            steps.each_with_index do |step, index|
              puts "#{driver.name}: step (#{index})"

              driver.update lat: step[:lat], lng: step[:lng]
              puts "#{driver.name}: waiting #{step[:wait]} seconds"
              sleep(step[:wait])
            end
          end
        end
      }
      sleep(20) # ensure that the driver is 5 seconds behind
    end

    threads.each(&:join)
  end
end
