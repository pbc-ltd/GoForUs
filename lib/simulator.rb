class Simulator
  def self.execute(paths, step_timer = 1)
    _d = Partner.find_by(email: 'tim_westwood@example.com')
    _d.delete if _d

    driver = Partner.create!(name: 'Tim Westwood', email: 'tim_westwood@example.com', password: 'password')
    paths.each_with_index do |path, index|
      puts "step (#{index})"

      driver.update lat: path[:lat], lng: path[:lng]
      sleep(step_timer)
    end

    driver.delete
  end
end
