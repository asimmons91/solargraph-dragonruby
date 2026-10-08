class Numeric
  # Treating self as the tick an animation started, returns a Hash describing
  # the current frame: `frame_index`, `frame_count`, `frames_left`, `started`,
  # `completed`, `elapsed_time`, `frame_elapsed_time`, `duration`.
  # Takes the same arguments as #frame_index.
  #
  # @return [Hash]
  def frame *args, **kwargs; end

  # Treating self as the tick an animation started, returns the index of the
  # sprite to show, or `nil` when the animation is out of bounds.
  #
  # @example positional
  #   0.frame_index 6, 4, true
  # @example named (also `Numeric.frame_index start_at: 0, ...`)
  #   0.frame_index count: 6, hold_for: 4, repeat: true, repeat_index: 0
  #
  # @return [Integer, nil]
  def frame_index *args, **kwargs; end

  # @param tick_count_override [Integer, nil] used instead of `Kernel.tick_count`
  # @return [Integer] frames elapsed since self
  def elapsed_time tick_count_override = nil; end

  # @param offset [Integer] added to self before comparing
  # @return [Boolean] true if #elapsed_time is greater than self (+ offset)
  def elapsed? offset = 0; end

  # @return [String] "string float" with two decimal places (`5.8778` => `"5.88"`)
  def to_sf; end

  # @return [String] "string int" with `_` thousands separators (`50000.8778` => `"50_000"`)
  def to_si; end

  # @return [Float] x component of the vector for self as an angle in degrees
  def vector_x; end

  # @return [Float] y component of the vector for self as an angle in degrees
  def vector_y; end

  # @return [Float] x component of the vector for self as an angle in radians
  def vector_x_r; end

  # @return [Float] y component of the vector for self as an angle in radians
  def vector_y_r; end

  # @param other [Numeric]
  # @return [Integer] integer division (`5.0.idiv(3)` => `1`)
  def idiv other; end

  # @param other [Numeric]
  # @return [Boolean] true if `self % other == 0`
  def zmod? other; end

  # @return [Float] self (degrees) converted to radians
  def to_radians; end

  # @return [Float] self (radians) converted to degrees
  def to_degrees; end

  # Returns self, `l`, or `r`, whichever keeps the value within `l..r`
  # (in either order). Either bound may be omitted or `nil`.
  #
  # @example
  #   10.mid(0, 5)         # => 5
  #   10.mid(l: 0, r: 5)   # => 5
  #   10.mid(r: 5)         # => 5
  #
  # @return [Numeric]
  def mid *lr, l: nil, r: nil; end

  # Takes the same arguments as #mid.
  #
  # @return [Boolean] true if self is within `l..r` (in either order)
  def mid? *lr, l: nil, r: nil; end

  # Same as #mid?: unlike Comparable#between?, the bounds may be in either
  # order, omitted, or named.
  #
  # @return [Boolean]
  def between? *lr, l: nil, r: nil; end

  # @example
  #   10.min(5)   # => 5
  #
  # @param n [Numeric, nil]
  # @return [Numeric] the smaller of self and `n` (self if `n` is `nil`)
  def min n = nil; end

  # @example
  #   0.max(5)   # => 5
  #
  # @param n [Numeric, nil]
  # @return [Numeric] the larger of self and `n` (self if `n` is `nil`)
  def max n = nil; end

  class << self
    # Expanded `rand` that also accepts a Range (`Numeric.rand(-10..10)`).
    #
    # @param max [Numeric, Range, nil]
    # @return [Numeric]
    def rand max = nil; end

    # Named-argument variant of Numeric#frame_index.
    #
    # @return [Integer, nil]
    def frame_index start_at:, count: nil, frame_count: nil, hold_for: 1, repeat: false, repeat_index: 0, tick_count_override: nil; end

    # Returns `m`, `l`, or `r`, whichever keeps the value within `l..r`
    # (in either order).
    #
    # @example
    #   Numeric.mid(l: 0, m: 10, r: 5)   # => 5
    #
    # @param l [Numeric, nil]
    # @param m [Numeric]
    # @param r [Numeric, nil]
    # @return [Numeric, nil] `nil` if `m` is `nil`
    def mid l: nil, m: nil, r: nil; end

    # Packs a custom blend mode for a primitive's `blendmode:`, mostly
    # used when rendering to a render target. Factors are the
    # `BLENDFACTOR_*` constants and operations the `BLENDOPERATION_*` ones:
    #
    #   dstRGB = color_operation(srcRGB * src_color_factor, dstRGB * dst_color_factor)
    #   dstA   = alpha_operation(srcA * src_alpha_factor, dstA * dst_alpha_factor)
    #
    # @example hole punch
    #   Numeric.compose_blendmode(BLENDFACTOR_ZERO, BLENDFACTOR_ONE_MINUS_SRC_ALPHA, BLENDOPERATION_ADD,
    #                             BLENDFACTOR_ZERO, BLENDFACTOR_ONE_MINUS_SRC_ALPHA, BLENDOPERATION_ADD)
    #
    # @param src_color_factor [Integer]
    # @param dst_color_factor [Integer]
    # @param color_operation [Integer]
    # @param src_alpha_factor [Integer]
    # @param dst_alpha_factor [Integer]
    # @param alpha_operation [Integer]
    # @return [Integer]
    def compose_blendmode src_color_factor, dst_color_factor, color_operation, src_alpha_factor, dst_alpha_factor, alpha_operation; end
  end
end

# Blend operations and factors for Numeric.compose_blendmode.
BLENDOPERATION_ADD              = 0x1
BLENDOPERATION_SUBTRACT         = 0x2
BLENDOPERATION_REV_SUBTRACT     = 0x3
BLENDOPERATION_MINIMUM          = 0x4
BLENDOPERATION_MAXIMUM          = 0x5
BLENDFACTOR_ZERO                = 0x1
BLENDFACTOR_ONE                 = 0x2
BLENDFACTOR_SRC_COLOR           = 0x3
BLENDFACTOR_ONE_MINUS_SRC_COLOR = 0x4
BLENDFACTOR_SRC_ALPHA           = 0x5
BLENDFACTOR_ONE_MINUS_SRC_ALPHA = 0x6
BLENDFACTOR_DST_COLOR           = 0x7
BLENDFACTOR_ONE_MINUS_DST_COLOR = 0x8
BLENDFACTOR_DST_ALPHA           = 0x9
BLENDFACTOR_ONE_MINUS_DST_ALPHA = 0xA
