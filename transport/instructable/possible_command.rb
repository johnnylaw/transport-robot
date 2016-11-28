module Transport
  module Instructable
    class PossibleCommand < Struct.new(:name, :arity)
      def pattern
        args_pattern = arity == 1 ? ' ([^\s]+)' : ''
        Regexp.new('\A' + name.to_s.upcase + args_pattern + '(?:\s|\Z)')
      end
    end
  end
end