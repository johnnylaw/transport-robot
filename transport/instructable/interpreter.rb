module Transport
  module Instructable
    def listen_up!(message)
      if public_methods.include? message.downcase.to_sym
        send message.downcase
      end
    end
  end
end