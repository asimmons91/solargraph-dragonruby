# frozen_string_literal: true

module Solargraph
  module Dragonruby
    # Adds pins parsed from the bundled DragonRuby YARD stubs to every ApiMap.
    class Convention < Solargraph::Convention::Base
      STUBS_DIR = File.expand_path("../../../stubs", __dir__)

      # Parsed once per process. ApiMap#catalog asks for global pins on every
      # re-map, and returning the same pin objects keeps the store from
      # reindexing them.
      #
      # @return [Array<Solargraph::Pin::Base>]
      def self.pins
        @pins ||= begin
          upstream = load_pins("upstream")
          extensions = load_pins("extensions")
          # Solargraph prefers the first method pin for a path, so an extension
          # that re-declares an upstream method (e.g. to add a return type)
          # only takes effect if the upstream pin is dropped.
          overridden = extensions.grep(Solargraph::Pin::Method).to_set(&:path)
          upstream.reject { |pin| pin.is_a?(Solargraph::Pin::Method) && overridden.include?(pin.path) }
            .concat(extensions)
            .freeze
        end
      end

      # @param dir [String]
      # @return [Array<Solargraph::Pin::Base>]
      def self.load_pins(dir)
        Dir[File.join(STUBS_DIR, dir, "*.rb")].sort
          .flat_map { |path| Solargraph::SourceMap.load(path).all_pins }
      end
      private_class_method :load_pins

      # @param _object [Object, nil] unused; Solargraph 0.61 passes nil
      # @return [Solargraph::Environ]
      def global(_object)
        Solargraph::Environ.new(pins: self.class.pins.dup)
      end
    end
  end
end
