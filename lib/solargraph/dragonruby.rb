# frozen_string_literal: true

require "solargraph"
require_relative "dragonruby/version"
require_relative "dragonruby/convention"
require_relative "dragonruby/macro_node"

module Solargraph
  # Solargraph plugin providing DragonRuby Game Toolkit API pins.
  module Dragonruby
  end
end

Solargraph::Convention.register Solargraph::Dragonruby::Convention
Solargraph::Parser::NodeProcessor.register :send, Solargraph::Dragonruby::MacroNode
