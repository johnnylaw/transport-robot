module Transport
  class Directions
    class Direction < Struct.new(:name, :coordinates); end

    def set_by_name(name)
      self.index = direction_options.index do |option|
        option.name == name
      end
    end

    def coordinates
      current = direction_options[index] if index
      current && current.coordinates
    end

    def to_s
      current = direction_options[index] if index
      current && current.name || ''
    end

    def change(*args)
      make_change(*args)
    end

    def direction_options
      raise NotImplementedError, 'Subclasses of Directions must implement #direction_options method'
    end

    def make_change
      raise NotImplementedError, 'Subclasses of Directions must implement #make_change method'
    end

    private

    attr_accessor :index
  end
end