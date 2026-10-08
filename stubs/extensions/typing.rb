# Phantom types for the shapes DragonRuby passes around as plain Hashes.
# None of these exist in the runtime.
#
# - The modules (`Typing::Point`, `Typing::Rect`, `Typing::Line`, ...) describe
#   duck-typed arguments: a Hash with those keys, or any object with those
#   methods. Parameters use them as `[Typing::Rect, Object]` so that any value
#   still type-checks.
# - The `*Hash` classes describe Hashes DragonRuby returns. They subclass
#   Hash, so both the Hash methods and the fields complete.
module Typing
  # phantom type denoting a line-like object
  module Line
    # @return [Integer, Float]
    attr_reader :x, :y, :x2, :y2
  end

  # phantom type denoting a circle-like object
  module Circle
    # @return [Integer, Float]
    attr_reader :x, :y, :radius
  end

  # phantom type denoting an object with a color
  module Color
    # @return [Integer] `0` to `255`
    attr_reader :r, :g, :b, :a
  end

  # phantom type denoting an object with a size
  module Size
    # @return [Integer, Float]
    attr_reader :w, :h
  end

  # A `{ x:, y: }` Hash: a point or a vector.
  class PointHash < ::Hash
    include Typing::Point
  end

  # A `{ x:, y:, w:, h: }` Hash.
  class RectHash < ::Hash
    include Typing::Rect
  end

  # A `{ x:, y:, w:, h:, center: { x:, y: } }` Hash, as returned by
  # `Layout.rect` and `Geometry.rect_props`.
  class RectPropsHash < RectHash
    # @return [Typing::PointHash] center of the rect
    attr_reader :center
  end

  # A `{ x:, y:, x2:, y2: }` Hash.
  class LineHash < ::Hash
    include Typing::Line
  end

  # A `{ x:, y:, radius: }` Hash.
  class CircleHash < ::Hash
    include Typing::Circle
  end

  # A `{ r:, g:, b:, a: }` Hash.
  class ColorHash < ::Hash
    include Typing::Color
  end

  # A `{ w:, h: }` Hash.
  class SizeHash < ::Hash
    include Typing::Size
  end

  # The Hash returned by `Numeric#frame`.
  class FrameHash < ::Hash
    # @return [Integer, nil] index of the sprite to show; `nil` before the start or after a non-repeating end
    attr_reader :frame_index

    # @return [Integer]
    attr_reader :frame_count

    # @return [Integer]
    attr_reader :frames_left

    # @return [Boolean]
    attr_reader :started

    # @return [Boolean]
    attr_reader :completed

    # @return [Integer] ticks since the start
    attr_reader :elapsed_time

    # @return [Integer, nil] ticks spent on the current frame
    attr_reader :frame_elapsed_time

    # @return [Integer] ticks for one run of the animation
    attr_reader :duration

    # @return [Integer]
    attr_reader :hold_for

    # @return [Boolean]
    attr_reader :repeat

    # @return [Object, nil] the `metadata:` that was passed in
    attr_reader :metadata
  end

  # The Hash returned by `DR.http_get` and the other http functions. It is
  # filled in asynchronously: check #complete before reading the response.
  class HTTPResponseHash < ::Hash
    # @return [Boolean] true once the request has finished
    attr_reader :complete

    # @return [Integer] e.g. `200`
    attr_reader :http_response_code

    # @return [String]
    attr_reader :response_data

    # @return [Hash{String => String}]
    attr_reader :response_headers

    # Set to true to cancel the request.
    # @return [Boolean]
    attr_accessor :cancel
  end

  # The Hash returned by `DR.stat_file`.
  class FileStatHash < ::Hash
    # @return [String]
    attr_reader :path

    # @return [Integer]
    attr_reader :file_size

    # @return [Integer]
    attr_reader :mod_time, :create_time, :access_time

    # @return [Boolean]
    attr_reader :readonly

    # @return [Symbol] `:regular`, `:directory`, `:symlink`, or `:other`
    attr_reader :file_type
  end

  # The Hash returned by `args.inputs.keyboard.keys`.
  class KeyStatesHash < ::Hash
    # @return [Array<Symbol>] keys pressed on this frame
    attr_reader :down

    # @return [Array<Symbol>] keys held
    attr_reader :held

    # @return [Array<Symbol>] keys pressed on this frame or held
    attr_reader :down_or_held

    # @return [Array<Symbol>] keys released on this frame
    attr_reader :up

    # @return [Array<Symbol>] keys pressed or repeated
    attr_reader :repeat
  end

  # An entry of `args.outputs.render_target_state`.
  class RenderTargetEntryHash < ::Hash
    # @return [String] render target name
    attr_reader :id, :path

    # @return [Boolean] true once the texture can be used
    attr_reader :ready

    # @return [Integer] `Kernel.tick_count` the texture is expected to be ready
    attr_reader :ready_at

    # @return [Integer]
    attr_reader :updated_at, :global_updated_at, :global_created_at

    # @return [Integer, Float]
    attr_reader :w, :h
  end

  # The Hash assigned to `outputs.shader`.
  class ShaderHash < ::Hash
    # @return [String] the required shader file
    attr_reader :path

    # @return [Array<Hash>] values bound in order, each `{ type: :int | :float, value: }`
    attr_reader :uniforms

    # @return [Array<Symbol>] render targets bound as additional textures
    attr_reader :textures
  end
end
