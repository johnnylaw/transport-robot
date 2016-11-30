module Transport
  class Directions
    class Direction < Struct.new(:name, :coordinates); end

    def set_by_name(name)

    end

    def coordinates
      direction_options.first.coordinates
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
  end
end