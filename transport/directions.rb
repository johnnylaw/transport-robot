module Transport
  class Directions
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