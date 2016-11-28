require File.expand_path('../possible_command', __FILE__)

module Transport
  module Instructable
    class Interpreter
      def initialize(listener)
        @listener = listener
      end

      def interpret(message)
        while message.length > 0
          if instruction = parse_next_instruction(message)
            listener.send *instruction.sendable_list
          end
        end
      end

      private

      attr_reader :listener

      def commands
        @commands ||= begin
          listener.public_methods(false).map do |method|
            arity = listener.public_method(method).arity
            PossibleCommand.new(method, arity)
          end
        end
      end

      def parse_next_instruction(message)
        commands.each do |command|
          matches = message.match command.pattern
          if matches
            message.sub! matches[0], ''
            return Instruction.new(command.name, matches[1..-1])
          end
        end
        message.sub!(/\A[^\s]*\s?/, '')
        nil
      end

      class Instruction < Struct.new(:method, :args)
        def sendable_list
          [method, args].flatten.compact
        end
      end
    end
  end
end