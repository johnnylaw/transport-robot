module Transport
  module Instructable
    def listen_up!(message)
      while token = eat_token(message)
        if public_methods.include? token.downcase.to_sym
          send token.downcase
        end
      end
    end

    private

    def eat_token(message)
      puts "message: '#{message}'"
      matches = message.match /\A[^\s]+/
      if matches
        message.sub! matches[0], ''
        message.sub! /\A\s/, ''
        return matches[0]
      end
    end
  end
end