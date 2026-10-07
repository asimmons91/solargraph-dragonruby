module Typing
  # phantom type for the properties every DragonRuby entity has
  module Entity
    # @return [Integer] automatically assigned id
    attr_reader :entity_id

    # @return [Symbol, nil]
    attr_reader :entity_type

    # @return [Integer] `Kernel.tick_count` when the entity was created
    attr_reader :created_at

    # @return [Integer] ticks elapsed since creation
    def created_at_elapsed; end

    # @return [Integer] `Kernel.global_tick_count` when the entity was created
    attr_reader :global_created_at

    # @return [Integer] global ticks elapsed since creation
    def global_created_at_elapsed; end

    # @return [Hash] the entity cast to a `Hash`, so values can be updated as if it were a `Hash`
    def as_hash; end
  end
end

module GTK
  # Backing type of `args.state`. Any property can be read or assigned
  # (`args.state.player.x ||= 0`); only the built-in ones are listed here.
  class OpenEntity
    include Typing::Entity

    # @return [Integer] the current tick of the game (same as `Kernel.tick_count`)
    def tick_count; end

    # Creates a new entity that accepts arbitrary properties.
    #
    # @example
    #   args.state.bullets << args.state.new_entity(:bullet) do |b|
    #     b.x = 0
    #   end
    #
    # @param entity_type [Symbol]
    # @param init_hash [Hash, nil] initial property values
    # @yieldparam entity [GTK::OpenEntity]
    # @return [GTK::OpenEntity]
    def new_entity entity_type, init_hash = nil, &block; end

    # Creates a new entity that only allows the properties given in `init_hash`.
    #
    # @param entity_type [Symbol]
    # @param init_hash [Hash, nil] the allowed properties and their initial values
    # @yieldparam entity [GTK::StrictEntity]
    # @return [GTK::StrictEntity]
    def new_entity_strict entity_type, init_hash = nil, &block; end
  end

  # Entity returned by `new_entity_strict`; only the properties it was created
  # with can be read or assigned.
  class StrictEntity
    include Typing::Entity
  end
end
