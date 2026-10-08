class ::Array
  # For an array of arrays, yields each element with its row and column index.
  #
  # @yieldparam row [Integer]
  # @yieldparam col [Integer]
  # @yieldparam value [Object]
  # @return [Array<Array>]
  def map_2d &block; end

  # @param items [Array<Object>]
  # @return [Boolean] true if any of `items` is in self
  def include_any? *items; end

  # @param other [Typing::Rect, Object] a rect
  # @param tolerance [Float]
  # @return [Boolean] true if any element intersects `other`
  def any_intersect_rect? other, tolerance = 0.1; end

  # Alias of `compact`.
  # @return [Array]
  def reject_nil; end

  # @return [Array] self without `nil` or `false` items
  def reject_false; end
end
