module Transport
  module Instructable
    class Interpreter
      def initialize(listener)
        @listener = listener
      end

      def interpret(message)
        while token = eat_token(message)
          if listener.public_methods.include? token.downcase.to_sym
            listener.send token.downcase
          end
        end
      end

      private

      attr_reader :listener

      def eat_token(message)
        matches = message.match /\A[^\s]+/
        if matches
          message.sub! matches[0], ''
          message.sub! /\A\s/, ''
          return matches[0]
        end
      end
    end
  end
end