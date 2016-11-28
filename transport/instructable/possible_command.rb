module Transport
  module Instructable
    class PossibleCommand < Struct.new(:name, :arity)
      def pattern
        Regexp.new('\A' + name.to_s.upcase + args_pattern + '(?:\s|\Z)')
      end

      private

      def args_pattern
        " #{([PER_ARG_PATTERN] * arity).join(',')}".sub(/\A \Z/, '')
      end

      PER_ARG_PATTERN = '([^\s]+)'
      private_constant :PER_ARG_PATTERN
    end
  end
end