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
