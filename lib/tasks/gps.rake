require_relative '../simulator.rb'

namespace :gps do
  desc ""
  task simulator: :environment do |t, args|
    driver = Partner.find_by(email: 'tim_westwood@example.com')
    driver = Partner.create!(name: 'Tim Westwood', email: 'tim_westwood@example.com', password: 'password') unless driver

    gpx = Gpx = GPX::GPXFile.new(gpx_file: File.join(File.dirname(__FILE__), "../../gpx_files/routes.gpx"))
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
          puts "step (#{index})"

          driver.update lat: step[:lat], lng: step[:lng]
          puts "waiting #{step[:wait]} seconds"
          sleep(step[:wait])
        end
      end
    end
  end
end
