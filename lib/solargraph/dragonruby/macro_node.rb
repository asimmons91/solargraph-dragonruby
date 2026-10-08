# frozen_string_literal: true

module Solargraph
  module Dragonruby
    # Maps DragonRuby's class macros (`attr_dr`, `attr_sprite`, ...) to the
    # module each one includes (see stubs/extensions/attr.rb), so Solargraph
    # treats `attr_sprite` like `include AttrSprite`.
    #
    # This is a node processor rather than a Convention#local because
    # Solargraph 0.61 doesn't notice when a file's convention pins change, so
    # adding or removing a macro wouldn't take effect until a restart.
    class MacroNode < Solargraph::Parser::NodeProcessor::Base
      MACROS = {
        attr_dr: "AttrDR",
        attr_gtk: "AttrDR",
        attr_sprite: "AttrSprite",
        attr_rect: "AttrRect",
        attr_label: "AttrLabel",
        attr_line: "AttrLine"
      }.freeze

      # Runs after Solargraph's own SendNode, which has already processed the
      # children, so this only adds the include.
      #
      # @return [Boolean] true, so later :send processors still run
      def process
        receiver, name, *arguments = node.children
        return true unless receiver.nil? && arguments.empty? && MACROS.key?(name) && region.scope != :class

        # Called in an instance method, the macro includes into `self.class`.
        closure = region.closure.is_a?(Solargraph::Pin::Method) ? region.closure.closure : region.closure
        return true unless closure.is_a?(Solargraph::Pin::Namespace) && !closure.path.empty?

        pins.push Solargraph::Pin::Reference::Include.new(
          location: location,
          closure: closure,
          name: MACROS[name],
          source: :dragonruby
        )
        true
      end
    end
  end
end
