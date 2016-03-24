require_relative '../simulator.rb'

namespace :gps do
  desc ""
  task simulator: :environment do |t, args|
    gpx = GPX::GPXFile.new(gpx_file: File.join(File.dirname(__FILE__), "../../gpx_files/routes.gpx"))

    paths = []
    gpx.tracks.each do |track|
      track.segments.each do |segement|
        paths << segement.points.map{|w| { lat: w.lat, lng: w.lon } }
      end
    end

    Simulator.execute(paths.flatten, 1.4)
  end
end
