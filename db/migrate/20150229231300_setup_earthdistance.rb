class SetupEarthdistance < ActiveRecord::Migration
  def self.up
    enable_extension  :cube
    enable_extension :earthdistance
  end

  def self.down
    disable_extension :earthdistance
    disable_extension :cube
  end
end
