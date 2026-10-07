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
  # (in either order).
  #
  # @param l [Numeric]
  # @param r [Numeric]
  # @return [Numeric]
  def mid l, r; end

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
  end
end
