module Deactivateable
  module Model
    extend ActiveSupport::Concern

    included do
    end

    def destroy!
      deactivate!
    end

    def activate!
      update!(deactivated: false)
    end

    def deactivate!
      update!(deactivated: true)
    end
  end
end
