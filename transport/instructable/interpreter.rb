module Transport
  module Instructable
    class Interpreter
      def initialize(listener)
        @listener = listener
      end

      def interpret(message)
        while token = eat_token(message)
          if listener.public_methods(false).include? token.downcase.to_sym
            listener.send token.downcase
          end
        end
      end

      private

      attr_reader :listener

      def commands
        @commands ||= listener.public_methods(false).map do |method|
          method.to_s.upcase
        end
      end

      def eat_token(message)
        commands.each do |command|
          matches = message.match command
          if matches
            message.sub! matches[0], ''
            return command.downcase
          end
        end
        nil
      end
    end
  end
end