module Transport
  module Instructable

    def listen_up!(message)
      interpreter.interpret(message)
    end

    private

    def interpreter
      @interpreter ||= Interpreter.new(self)
    end
  end
end

require File.expand_path('../instructable/interpreter', __FILE__)
