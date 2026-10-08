module GTK
  module Geometry
    class << self
      # @param v1 [Object] a vector (a Hash with x and y keys, or an Object that responds to x and y)
      # @param v2 [Object] a vector
      # @return [Hash] `x`, `y` sum of the two vectors
      def vec2_add v1, v2; end

      # @param v1 [Object] a vector
      # @param v2 [Object] a vector
      # @return [Hash] `x`, `y` difference of the two vectors
      def vec2_subtract v1, v2; end

      # Alias of #vec2_subtract.
      # @param v1 [Object] a vector
      # @param v2 [Object] a vector
      # @return [Hash]
      def vec2_sub v1, v2; end

      # @param v [Object] a vector
      # @param scalar [Numeric]
      # @return [Hash] `x`, `y` with each component multiplied by `scalar`
      def vec2_scale v, scalar; end

      # @param v1 [Object] a vector
      # @param v2 [Object] a vector
      # @return [Float] dot product of the two vectors
      def vec2_dot_product v1, v2; end

      # @param v [Object] a vector
      # @return [Float] magnitude of the vector
      def vec2_magnitude v; end

      # @param v [Object] a vector
      # @return [Hash] `x`, `y` normal of the vector
      def vec2_normal v; end

      # @param v [Object] a vector
      # @return [Hash] `x`, `y` normalized vector
      def vec2_normalize v; end

      # @param v [Object] a vector
      # @return [Float] angle of the vector in degrees (`0` to `359.9`)
      def vec2_angle v; end

      # @param angle [Numeric] degrees
      # @return [Hash] `x`, `y` vector components of the angle
      def angle_vec2 angle; end

      # @param angle [Numeric] radians
      # @return [Hash] `x`, `y` vector components of the angle
      def angle_vec2_r angle; end

      # @param angle [Numeric] degrees
      # @return [Hash] `x`, `y` vector components snapped to 45 degree angles (like a dpad)
      def angle_cardinal_vec2 angle; end

      # @param angle [Numeric] radians
      # @return [Hash] `x`, `y` vector components snapped to 45 degree angles (like a dpad)
      def angle_cardinal_vec2_r angle; end

      # @param rect [Object] a rect (`x`, `y`, `w`, `h`, optional `anchor_x`, `anchor_y`)
      # @return [Hash] `x`, `y` center point of the rect
      def rect_center_point rect; end

      # Alias of #rect_center_point.
      # @param rect [Object]
      # @return [Hash]
      def center rect; end

      # @param line [Object] a line (`x`, `y`, `x2`, `y2`)
      # @return [Hash] `x`, `y` center point of the line
      def line_center_point line; end

      # @param line [Object] a line (`x`, `y`, `x2`, `y2`)
      # @return [Hash] `x`, `y` midpoint of the line
      def line_midpoint line; end

      # @param line [Object] a line (`x`, `y`, `x2`, `y2`)
      # @return [Hash] `x`, `y` vector of the line
      def line_vec2 line; end

      # @param p1 [Object] start point
      # @param p2 [Object] end point
      # @return [Hash] a line (`x`, `y`, `x2`, `y2`) from `p1` to `p2`
      def points_to_line p1, p2; end

      # @param shape [Object] a circle (`x`, `y`, `radius`) or a rect
      # @return [Hash] the smallest circle containing `shape`
      def rect_to_circle shape; end

      # @param shape_1 [Object] a circle (`x`, `y`, `radius`) or a rect
      # @param shape_2 [Object] a circle (`x`, `y`, `radius`) or a rect
      # @return [Boolean] true if the shapes intersect (rects are treated as circles)
      def intersect_circle? shape_1, shape_2; end

      # @param rect [Object]
      # @param anchor_x [Float] e.g. `0.5` to center horizontally
      # @param anchor_y [Float] e.g. `0.5` to center vertically
      # @return [Hash] a new rect anchored by `anchor_x` and `anchor_y`
      def anchor_rect rect, anchor_x, anchor_y; end

      # @param p0 [Object] control point (`x`, `y`)
      # @param p1 [Object] control point
      # @param p2 [Object] control point
      # @param p3 [Object] control point
      # @param t [Float] `0.0` to `1.0`
      # @return [Hash] `x`, `y` point on the curve at `t`
      def cubic_bezier_vec2 p0, p1, p2, p3, t; end

      # @param test_angle [Float] degrees
      # @param target_angle [Float] degrees
      # @param range [Float] degrees on either side of `target_angle`
      # @return [Boolean] true if `test_angle` is within `range` of `target_angle`
      def angle_within_range? test_angle, target_angle, range; end

      # @param rect [Object] a rect
      # @param other_rect [Object] a rect
      # @return [Hash] `rect` centered horizontally inside `other_rect` (and moved to its `y`)
      def center_inside_rect_x rect, other_rect; end

      # @param rect [Object] a rect
      # @param other_rect [Object] a rect
      # @return [Hash] `rect` centered vertically inside `other_rect` (and moved to its `x`)
      def center_inside_rect_y rect, other_rect; end

      # @param line [Object] `x`, `y`, `x2`, `y2`
      # @return [Float] length of `line`
      def line_length line; end

      # @param line [Object] `x`, `y`, `x2`, `y2`
      # @param replace_infinity [Numeric] returned (with sign) for vertical lines
      # @return [Numeric] slope of `line`; raises for a zero-length line
      def line_slope line, replace_infinity: Float::INFINITY; end

      # @param line [Object] `x`, `y`, `x2`, `y2`
      # @param replace_infinity [Numeric, nil] slope to use for vertical lines
      # @return [Numeric] y where `line` (extended) crosses `x = 0`
      def line_y_intercept line, replace_infinity: nil; end

      # @param line_one [Object] `x`, `y`, `x2`, `y2`
      # @param line_two [Object] `x`, `y`, `x2`, `y2`
      # @param replace_infinity [Numeric, nil] slope to use for vertical lines
      # @return [Float] angle in degrees between the lines
      def angle_between_lines line_one, line_two, replace_infinity: nil; end

      # @param line [Object] `x`, `y`, `x2`, `y2`
      # @return [Boolean] true if `line` is horizontal
      def line_horizontal? line; end

      # @param line [Object] `x`, `y`, `x2`, `y2`
      # @return [Boolean] true if `line` is vertical
      def line_vertical? line; end

      # @param line [Object] `x`, `y`, `x2`, `y2`
      # @param x [Numeric]
      # @param y [Numeric]
      # @return [Hash, Array] a copy of `line` moved by `x`, `y`
      def shift_line line, x, y; end

      # @param line [Object] `x`, `y`, `x2`, `y2`
      # @param min_w [Numeric]
      # @param min_h [Numeric]
      # @return [Hash] bounding rect of `line`, at least `min_w` by `min_h`
      def line_rect line, min_w: 0, min_h: 0; end

      # Same as #line_rect.
      #
      # @param line [Object]
      # @param min_w [Numeric]
      # @param min_h [Numeric]
      # @return [Hash]
      def line_to_rect line, min_w: 0, min_h: 0; end

      # @param rect [Object] `x`, `y`, `w`, `h`
      # @return [Hash] `x`, `y`, `x2`, `y2` diagonal of `rect`
      def rect_to_line rect; end

      # @param shape [Object]
      # @return [Boolean] true if `shape` has `w` and `h`
      def rect? shape; end

      # @param shape [Object]
      # @return [Boolean] true if `shape` has `x2` and `y2`
      def line? shape; end

      # @param shape [Object]
      # @return [Boolean] true if `shape` has a `radius`
      def circle? shape; end

      # Like #intersect_rect?, for any shapes with a bounding box (circles,
      # rects, lines, points).
      #
      # @param inner_shape [Object]
      # @param outer_shape [Object]
      # @param tolerance [Float]
      # @return [Boolean, nil]
      def intersect_bounding_box? inner_shape, outer_shape, tolerance = 0.0; end

      # Like #inside_rect?, for any shapes with a bounding box.
      #
      # @param inner_shape [Object]
      # @param outer_shape [Object]
      # @param tolerance [Float]
      # @return [Boolean, nil]
      def inside_bounding_box? inner_shape, outer_shape, tolerance = 0.0; end

      # Value at `t` of a cubic bezier with control values `a`, `b`, `c`, `d`.
      #
      # @param t [Float] `0.0` to `1.0`
      # @param a [Numeric]
      # @param b [Numeric]
      # @param c [Numeric]
      # @param d [Numeric]
      # @return [Float]
      def cubic_bezier t, a, b, c, d; end
    end
  end
end

module Typing
  # phantom type for the Geometry functions DragonRuby mixes into Hash, Array and entities
  module GeometryMixin
    # @param other [Object] a rect
    # @param tolerance [Float]
    # @return [Boolean]
    def intersect_rect? other, tolerance = 0.1; end

    # @param other [Object] a rect
    # @return [Boolean] true if self is inside `other`
    def inside_rect? other; end

    # @param ratio [Float]
    # @return [Hash] a scaled copy of self
    def scale_rect ratio, anchor_x = 0, anchor_y = 0; end

    # @param other [Object] a point
    # @return [Float] angle in degrees from self to `other`
    def angle_to other; end

    # @param other [Object] a point
    # @return [Float] angle in degrees from `other` to self
    def angle_from other; end

    # @param circle_center [Object] a point
    # @param circle_radius [Numeric]
    # @return [Boolean]
    def point_inside_circle? circle_center, circle_radius; end

    # @param other [Object] a rect
    # @return [Hash] self centered inside `other`
    def center_inside_rect other; end

    # @param other [Object] a rect
    # @return [Hash] self centered horizontally inside `other`
    def center_inside_rect_x other; end

    # @param other [Object] a rect
    # @return [Hash] self centered vertically inside `other`
    def center_inside_rect_y other; end

    # @param anchor_x [Float]
    # @param anchor_y [Float]
    # @return [Hash] a new rect anchored by `anchor_x` and `anchor_y`
    def anchor_rect anchor_x, anchor_y; end

    # @return [Hash] `x`, `y` center point of self
    def rect_center_point; end

    # @return [Hash] bounding rect of self as a line
    def line_to_rect min_w: 0, min_h: 0; end

    # @return [Hash] `x`, `y`, `x2`, `y2` diagonal of self as a rect
    def rect_to_line; end
  end
end

class ::Hash
  include Typing::GeometryMixin
end

class ::Array
  include Typing::GeometryMixin
end

module GTK
  class OpenEntity
    include Typing::GeometryMixin
  end
end
