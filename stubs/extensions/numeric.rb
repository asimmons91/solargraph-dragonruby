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
  # @param decimal_places [Integer]
  # @param include_sign [Boolean] prefix positive numbers with `+`
  def to_sf decimal_places: 2, include_sign: false; end

  # @return [String] "string int" with `_` thousands separators (`50000.8778` => `"50_000"`)
  def to_si; end

  # @return [Float] x component of the vector for self as an angle in degrees
  # @param max_value [Numeric] length of the vector
  def vector_x max_value = 1; end

  # @return [Float] y component of the vector for self as an angle in degrees
  # @param max_value [Numeric] length of the vector
  def vector_y max_value = 1; end

  # @return [Float] x component of the vector for self as an angle in radians
  # @param max_value [Numeric] length of the vector
  def vector_x_r max_value = 1; end

  # @return [Float] y component of the vector for self as an angle in radians
  # @param max_value [Numeric] length of the vector
  def vector_y_r max_value = 1; end

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

  # @param max_value [Numeric] length of the vector
  # @return [Hash] `{ x:, y: }` vector for self as an angle in degrees
  def to_vector max_value = 1; end

  # @param max_value [Numeric] length of the vector
  # @return [Hash] `{ x:, y: }` vector for self as an angle in radians
  def to_vector_r max_value = 1; end

  # @return [Float] self / 2.0
  def half; end

  # @return [Float] self / 3.0
  def third; end

  # @return [Float] self / 4.0
  def quarter; end

  # Randomizes self. Options: `:ratio` (or `:float`) for a random float in
  # `0...self`, `:int` for a random integer in `0...self`, and `:sign` to
  # randomly negate. `:sign` combines with either of the others.
  #
  # @example
  #   10.randomize(:ratio, :sign)   # => a float between -10 and 10
  #
  # @param definitions [Array<Symbol>]
  # @return [Numeric]
  def randomize *definitions; end

  # @return [Integer] `-1` or `1`, at random
  def rand_sign; end

  # @return [Float] self multiplied by a random float in `0...1`
  def rand_ratio; end

  # @return [Integer] `-1`, `0`, or `1`
  def sign; end

  # @param int [Integer]
  # @return [Integer] self floored to a multiple of `int` (`17.ifloor(5)` => `15`)
  def ifloor int; end

  # @return [Float] sine of self in degrees
  def sin; end

  # @return [Float] sine of self in degrees
  def sin_d; end

  # @return [Float] sine of self in radians
  def sin_r; end

  # @return [Float] cosine of self in degrees
  def cos; end

  # @return [Float] cosine of self in degrees
  def cos_d; end

  # @return [Float] cosine of self in radians
  def cos_r; end

  # @return [Float] tangent of self in degrees
  def tan; end

  # @return [Float] tangent of self in degrees
  def tan_d; end

  # @return [Float] tangent of self in radians
  def tan_r; end

  # Moves self toward `target` by `magnitude`, without overshooting.
  #
  # @param target [Numeric]
  # @param magnitude [Numeric]
  # @return [Numeric]
  def towards target, magnitude; end

  # @param n [Numeric]
  # @return [Float] self / n, clamped to `0..1`
  def percentage_of n; end

  # @param i [Numeric]
  # @return [Numeric] self, but no greater than `i`
  def cap i; end

  # @param min [Numeric]
  # @param max [Numeric]
  # @return [Numeric] self clamped to `min..max`
  def cap_min_max min, max; end

  # @param n [Numeric]
  # @return [Numeric] self % n
  def mod n; end

  # @param ns [Array<Numeric>]
  # @return [Boolean] true if self is a multiple of any of `ns`
  def mod_zero? *ns; end

  # Same as #max.
  # @param n [Numeric, nil]
  # @return [Numeric]
  def greater n = nil; end

  # Same as #min.
  # @param n [Numeric, nil]
  # @return [Numeric]
  def lesser n = nil; end

  # @return [Numeric] `Grid.top - self`
  def from_top; end

  # @return [Numeric] `Grid.bottom + self`
  def from_bottom; end

  # @return [Numeric] `Grid.left + self`
  def from_left; end

  # @return [Numeric] `Grid.right - self`
  def from_right; end

  # Treating self as a start tick, #elapsed_time as a percentage of `duration`.
  #
  # @param duration [Integer]
  # @return [Float] `0.0` to `1.0`
  def elapsed_time_percent duration; end

  # @param tick_count_override [Integer, nil]
  # @return [Boolean] true if self is the current tick
  def new? tick_count_override; end

  # Treating self as a start tick, Easing.ease progress for `duration`.
  #
  # @example
  #   percentage = state.started_at.ease(120, :smooth_stop_quad)
  #
  # @param duration [Integer]
  # @param definitions [Array<Symbol, Proc>] easing definitions (`:identity`, `:flip`, `:quad`, ...)
  # @return [Float]
  def ease duration, *definitions; end

  # Like #ease, but measured against `Kernel.global_tick_count`.
  #
  # @param duration [Integer]
  # @param definitions [Array<Symbol, Proc>]
  # @return [Float]
  def global_ease duration, *definitions; end

  # Treating self as a start tick, Easing.spline progress for `duration`.
  #
  # @param duration [Integer]
  # @param spline [Array<Array<Numeric>>] bezier definitions, four values each
  # @return [Float]
  def ease_spline duration, spline; end

  # Like #ease_spline, but measured against `Kernel.global_tick_count`.
  #
  # @param duration [Integer]
  # @param spline [Array<Array<Numeric>>]
  # @return [Float]
  def global_ease_spline duration, spline; end

  # @return [Array<Integer>] `0` to self, inclusive
  def numbers; end

  # @param other_int [Integer]
  # @return [Array<Array(Integer, Integer)>] every pair of #numbers of self and `other_int`
  def combinations other_int; end

  # Yields every `x`, `y` with `x` in `0...self` and `y` in `0...ys`.
  #
  # @param ys [Integer]
  # @yieldparam x [Integer]
  # @yieldparam y [Integer]
  # @return [Array]
  def map_with_ys ys, &block; end

  # Like #times, but also yields the index.
  #
  # @return [Numeric]
  def times_with_index &blk; end

  # @param opts [Hash] `col:`, `w:`, `h:`
  # @return [Numeric] y of Layout row self
  def to_layout_row opts = {}; end

  # @param opts [Hash] `w:`, `h:`
  # @return [Numeric] x of Layout column self
  def to_layout_col opts = {}; end

  # @param opts [Hash]
  # @return [Numeric] y of Layout row self, counting from the bottom
  def to_layout_row_from_bottom opts = {}; end

  # @param opts [Hash]
  # @return [Numeric] x of Layout column self, counting from the right
  def to_layout_col_from_right opts = {}; end

  # @return [Numeric] width of self Layout columns
  def to_layout_w; end

  # @return [Numeric] height of self Layout rows
  def to_layout_h; end

  class << self
    # @param n [Numeric]
    # @return [Numeric] `Grid.top - n`
    def from_top n; end

    # @param n [Numeric]
    # @return [Numeric] `Grid.bottom + n`
    def from_bottom n; end

    # @param n [Numeric]
    # @return [Numeric] `Grid.left + n`
    def from_left n; end

    # @param n [Numeric]
    # @return [Numeric] `Grid.right - n`
    def from_right n; end

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

class Integer
  # @return [Boolean] true if self is greater than zero
  def pos?; end

  # @return [Boolean] true if self is less than zero
  def neg?; end
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
