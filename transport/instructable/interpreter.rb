module Transport
  module Instructable
    def listen_up!(message)
      send message.downcase
    end
  end
end