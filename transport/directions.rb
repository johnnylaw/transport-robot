module Transport
  class Directions
    class Direction < Struct.new(:name, :coordinates); end

    def set_by_name(name)
      proposed_index = direction_options.index do |option|
        option.name == name
      end
      if proposed_index
        self.index = proposed_index
        true
      else
        false
      end
    end

    def coordinates
      current && current.coordinates
    end

    def to_s
      current && current.name || ''
    end

    def change(*args)
      make_change(*args) if index
    end

    def direction_options
      raise NotImplementedError, 'Subclasses of Directions must implement #direction_options method'
    end

    def make_change
      raise NotImplementedError, 'Subclasses of Directions must implement #make_change method'
    end

    private

    def current
      index && direction_options[index]
    end

    attr_accessor :index
  end
end