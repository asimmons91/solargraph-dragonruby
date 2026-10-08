module GTK
  module Geometry
    class << self
      # @param v1 [Typing::Point, Object] a vector (a Hash with x and y keys, or an Object that responds to x and y)
      # @param v2 [Typing::Point, Object] a vector
      # @return [Typing::PointHash] `x`, `y` sum of the two vectors
      def vec2_add v1, v2; end

      # @param v1 [Typing::Point, Object] a vector
      # @param v2 [Typing::Point, Object] a vector
      # @return [Typing::PointHash] `x`, `y` difference of the two vectors
      def vec2_subtract v1, v2; end

      # Alias of #vec2_subtract.
      # @param v1 [Typing::Point, Object] a vector
      # @param v2 [Typing::Point, Object] a vector
      # @return [Typing::PointHash]
      def vec2_sub v1, v2; end

      # @param v [Typing::Point, Object] a vector
      # @param scalar [Numeric]
      # @return [Typing::PointHash] `x`, `y` with each component multiplied by `scalar`
      def vec2_scale v, scalar; end

      # @param v1 [Typing::Point, Object] a vector
      # @param v2 [Typing::Point, Object] a vector
      # @return [Float] dot product of the two vectors
      def vec2_dot_product v1, v2; end

      # @param v [Typing::Point, Object] a vector
      # @return [Float] magnitude of the vector
      def vec2_magnitude v; end

      # @param v [Typing::Point, Object] a vector
      # @return [Typing::PointHash] `x`, `y` normal of the vector
      def vec2_normal v; end

      # @param v [Typing::Point, Object] a vector
      # @return [Typing::PointHash] `x`, `y` normalized vector
      def vec2_normalize v; end

      # @param v [Typing::Point, Object] a vector
      # @return [Float] angle of the vector in degrees (`0` to `359.9`)
      def vec2_angle v; end

      # @param angle [Numeric] degrees
      # @return [Typing::PointHash] `x`, `y` vector components of the angle
      def angle_vec2 angle; end

      # @param angle [Numeric] radians
      # @return [Typing::PointHash] `x`, `y` vector components of the angle
      def angle_vec2_r angle; end

      # @param angle [Numeric] degrees
      # @return [Typing::PointHash] `x`, `y` vector components snapped to 45 degree angles (like a dpad)
      def angle_cardinal_vec2 angle; end

      # @param angle [Numeric] radians
      # @return [Typing::PointHash] `x`, `y` vector components snapped to 45 degree angles (like a dpad)
      def angle_cardinal_vec2_r angle; end

      # @param rect [Typing::Rect, Object] a rect (`x`, `y`, `w`, `h`, optional `anchor_x`, `anchor_y`)
      # @return [Typing::PointHash] `x`, `y` center point of the rect
      def rect_center_point rect; end

      # Alias of #rect_center_point.
      # @param rect [Typing::Rect, Object]
      # @return [Typing::PointHash]
      def center rect; end

      # @param line [Typing::Line, Object] a line (`x`, `y`, `x2`, `y2`)
      # @return [Typing::PointHash] `x`, `y` center point of the line
      def line_center_point line; end

      # @param line [Typing::Line, Object] a line (`x`, `y`, `x2`, `y2`)
      # @return [Typing::PointHash] `x`, `y` midpoint of the line
      def line_midpoint line; end

      # @param line [Typing::Line, Object] a line (`x`, `y`, `x2`, `y2`)
      # @return [Typing::PointHash] `x`, `y` vector of the line
      def line_vec2 line; end

      # @param p1 [Typing::Point, Object] start point
      # @param p2 [Typing::Point, Object] end point
      # @return [Typing::LineHash] a line (`x`, `y`, `x2`, `y2`) from `p1` to `p2`
      def points_to_line p1, p2; end

      # @param shape [Typing::Circle, Typing::Rect, Object] a circle (`x`, `y`, `radius`) or a rect
      # @return [Typing::CircleHash] the smallest circle containing `shape`
      def rect_to_circle shape; end

      # @param shape_1 [Typing::Circle, Typing::Rect, Object] a circle (`x`, `y`, `radius`) or a rect
      # @param shape_2 [Typing::Circle, Typing::Rect, Object] a circle (`x`, `y`, `radius`) or a rect
      # @return [Boolean] true if the shapes intersect (rects are treated as circles)
      def intersect_circle? shape_1, shape_2; end

      # @param rect [Typing::Rect, Object]
      # @param anchor_x [Float] e.g. `0.5` to center horizontally
      # @param anchor_y [Float] e.g. `0.5` to center vertically
      # @return [Typing::RectHash] a new rect anchored by `anchor_x` and `anchor_y`
      def anchor_rect rect, anchor_x, anchor_y; end

      # @param p0 [Typing::Point, Object] control point (`x`, `y`)
      # @param p1 [Typing::Point, Object] control point
      # @param p2 [Typing::Point, Object] control point
      # @param p3 [Typing::Point, Object] control point
      # @param t [Float] `0.0` to `1.0`
      # @return [Typing::PointHash] `x`, `y` point on the curve at `t`
      def cubic_bezier_vec2 p0, p1, p2, p3, t; end

      # @param test_angle [Float] degrees
      # @param target_angle [Float] degrees
      # @param range [Float] degrees on either side of `target_angle`
      # @return [Boolean] true if `test_angle` is within `range` of `target_angle`
      def angle_within_range? test_angle, target_angle, range; end

      # @param rect [Typing::Rect, Object] a rect
      # @param other_rect [Typing::Rect, Object] a rect
      # @return [Typing::RectHash] `rect` centered horizontally inside `other_rect` (and moved to its `y`)
      def center_inside_rect_x rect, other_rect; end

      # @param rect [Typing::Rect, Object] a rect
      # @param other_rect [Typing::Rect, Object] a rect
      # @return [Typing::RectHash] `rect` centered vertically inside `other_rect` (and moved to its `x`)
      def center_inside_rect_y rect, other_rect; end

      # @param line [Typing::Line, Object] `x`, `y`, `x2`, `y2`
      # @return [Float] length of `line`
      def line_length line; end

      # @param line [Typing::Line, Object] `x`, `y`, `x2`, `y2`
      # @param replace_infinity [Numeric] returned (with sign) for vertical lines
      # @return [Numeric] slope of `line`; raises for a zero-length line
      def line_slope line, replace_infinity: Float::INFINITY; end

      # @param line [Typing::Line, Object] `x`, `y`, `x2`, `y2`
      # @param replace_infinity [Numeric, nil] slope to use for vertical lines
      # @return [Numeric] y where `line` (extended) crosses `x = 0`
      def line_y_intercept line, replace_infinity: nil; end

      # @param line_one [Typing::Line, Object] `x`, `y`, `x2`, `y2`
      # @param line_two [Typing::Line, Object] `x`, `y`, `x2`, `y2`
      # @param replace_infinity [Numeric, nil] slope to use for vertical lines
      # @return [Float] angle in degrees between the lines
      def angle_between_lines line_one, line_two, replace_infinity: nil; end

      # @param line [Typing::Line, Object] `x`, `y`, `x2`, `y2`
      # @return [Boolean] true if `line` is horizontal
      def line_horizontal? line; end

      # @param line [Typing::Line, Object] `x`, `y`, `x2`, `y2`
      # @return [Boolean] true if `line` is vertical
      def line_vertical? line; end

      # @param line [Typing::Line, Object] `x`, `y`, `x2`, `y2`
      # @param x [Numeric]
      # @param y [Numeric]
      # @return [Typing::LineHash, Array] a copy of `line` moved by `x`, `y`
      def shift_line line, x, y; end

      # @param line [Typing::Line, Object] `x`, `y`, `x2`, `y2`
      # @param min_w [Numeric]
      # @param min_h [Numeric]
      # @return [Typing::RectHash] bounding rect of `line`, at least `min_w` by `min_h`
      def line_rect line, min_w: 0, min_h: 0; end

      # Same as #line_rect.
      #
      # @param line [Typing::Line, Object]
      # @param min_w [Numeric]
      # @param min_h [Numeric]
      # @return [Typing::RectHash]
      def line_to_rect line, min_w: 0, min_h: 0; end

      # @param rect [Typing::Rect, Object] `x`, `y`, `w`, `h`
      # @return [Typing::LineHash] `x`, `y`, `x2`, `y2` diagonal of `rect`
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

      # Re-declarations of upstream functions with typed shapes (and
      # signatures checked against the 7.22 runtime).

      # True if two rects intersect. The default tolerance of `0.1` keeps
      # rects that only share an edge from intersecting.
      #
      # @param rect_1 [Typing::Rect, Object]
      # @param rect_2 [Typing::Rect, Object]
      # @param tolerance [Float]
      # @return [Boolean]
      def intersect_rect? rect_1, rect_2, tolerance = 0.1; end

      # @param inner_rect [Typing::Rect, Object]
      # @param outer_rect [Typing::Rect, Object]
      # @param tolerance [Float]
      # @return [Boolean] true if `inner_rect` is inside `outer_rect`
      def inside_rect? inner_rect, outer_rect, tolerance = 0.0; end

      # A copy of `rect` scaled by `percentage` (`2.0` doubles its size).
      # Anchors (`0.0` to `1.0`) keep that point of the rect in place.
      #
      # @param rect [Typing::Rect, Object]
      # @param percentage [Float]
      # @param anchors [Array<Float>] `anchor_x`, then `anchor_y` (defaults to `anchor_x`)
      # @return [Typing::RectHash, Object] a Hash for a Hash, an Array for an Array; other objects are updated in place
      def scale_rect rect, percentage, *anchors; end

      # Like #scale_rect, with each axis scaled separately.
      #
      # @param rect [Typing::Rect, Object]
      # @param percentage_x [Float, nil] defaults to `1.0`
      # @param percentage_y [Float, nil] defaults to `1.0`
      # @param anchor_x [Float, nil] defaults to `0.0`
      # @param anchor_y [Float, nil] defaults to `0.0`
      # @return [Typing::RectHash, Object]
      def scale_rect_extended rect, percentage_x: nil, percentage_y: nil, anchor_x: nil, anchor_y: nil; end

      # @param start_point [Typing::Point, Object]
      # @param end_point [Typing::Point, Object]
      # @return [Float] angle in degrees from `start_point` to `end_point`
      def angle start_point, end_point; end

      # @param start_point [Typing::Point, Object]
      # @param end_point [Typing::Point, Object]
      # @return [Float] angle in degrees from `end_point` to `start_point`
      def angle_from start_point, end_point; end

      # @param start_point [Typing::Point, Object]
      # @param end_point [Typing::Point, Object]
      # @return [Float] angle in degrees from `start_point` to `end_point`
      def angle_to start_point, end_point; end

      # @param point_one [Typing::Point, Object]
      # @param point_two [Typing::Point, Object]
      # @return [Float] distance between the points
      def distance point_one, point_two; end

      # @param p1 [Typing::Point, Object]
      # @param p2 [Typing::Point, Object]
      # @return [Float] squared distance between the points (cheaper than #distance for comparisons)
      def distance_squared p1, p2; end

      # @param point [Typing::Point, Object]
      # @param circle_center_point [Typing::Point, Typing::Circle, Object] the center, or a circle with `radius`
      # @param radius [Numeric, nil] omit when `circle_center_point` has a `radius`
      # @return [Boolean] true if `point` is inside the circle
      def point_inside_circle? point, circle_center_point, radius = nil; end

      # @param rect [Typing::Rect, Object]
      # @param other_rect [Typing::Rect, Object]
      # @return [Typing::RectHash] `rect` centered inside `other_rect`
      def center_inside_rect rect, other_rect; end

      # @param point [Typing::Point, Object]
      # @param line [Typing::Line, Object]
      # @return [Symbol] `:left`, `:right`, or `:on`
      def ray_test point, line; end

      # @param line [Typing::Line, Object]
      # @return [Typing::PointHash] normalized rise (`y`) and run (`x`) of the line
      def line_rise_run line; end

      # Treats the lines as segments (see #ray_intersect for infinite lines).
      #
      # @param line_one [Typing::Line, Object]
      # @param line_two [Typing::Line, Object]
      # @return [Typing::PointHash, nil] the point of intersection, or `nil` if the segments don't intersect
      def line_intersect line_one, line_two; end

      # Treats the lines as infinite (see #line_intersect for segments).
      #
      # @param line_one [Typing::Line, Object]
      # @param line_two [Typing::Line, Object]
      # @return [Typing::PointHash, nil] the point of intersection, or `nil` if the lines are parallel
      def ray_intersect line_one, line_two; end

      # @param point [Typing::Point, Object]
      # @param angle [Numeric] degrees
      # @param around [Typing::Point, Object, nil] defaults to the origin
      # @return [Typing::PointHash] `point` rotated by `angle` around `around`
      def rotate_point point, angle, around = nil; end

      # @param line [Typing::Line, Object]
      # @return [Float] angle of the line in degrees
      def line_angle line; end

      # @param line [Typing::Line, Object]
      # @param point [Typing::Point, Object, nil] defaults to the start of the line
      # @return [Typing::PointHash] the point on the (infinite) line closest to `point`
      def line_normal line, point = nil; end

      # @param point [Typing::Point, Object]
      # @param line [Typing::Line, Object]
      # @param tolerance [Float]
      # @return [Boolean] true if `point` is on `line`
      def point_on_line? point, line, tolerance = 0.1; end

      # @param circle [Typing::Circle, Object]
      # @param line [Typing::Line, Object]
      # @return [Boolean] true if the circle intersects the line
      def circle_intersect_line? circle, line; end

      # The first rect in `haystack` that intersects `needle`. `anchor_x` and
      # `anchor_y` are honored.
      #
      # @param needle [Typing::Rect, Object]
      # @param haystack [Array<Typing::Rect, Object>]
      # @param using [Symbol, Proc, nil] method or lambda that returns each object's rect
      # @return [Object, nil] the matching element of `haystack`
      def find_intersect_rect needle, haystack, using: nil; end

      # Every rect in `haystack` that intersects `needle`.
      #
      # @param needle [Typing::Rect, Object]
      # @param haystack [Array<Typing::Rect, Object>]
      # @param using [Symbol, Proc, nil] method or lambda that returns each object's rect
      # @return [Array] the matching elements of `haystack`
      def find_all_intersect_rect needle, haystack, using: nil; end

      # Builds a quad tree for #find_intersect_rect_quad_tree.
      #
      # @param rects [Array<Typing::Rect, Object>]
      # @return [Object] the quad tree
      def create_quad_tree rects; end

      # A faster #find_intersect_rect for large, static collections.
      #
      # @param needle [Typing::Rect, Object]
      # @param quad_tree [Object] from #create_quad_tree
      # @return [Object, nil] the first intersecting rect
      def find_intersect_rect_quad_tree needle, quad_tree; end

      # A faster #find_all_intersect_rect for large, static collections.
      #
      # @param needle [Typing::Rect, Object]
      # @param quad_tree [Object] from #create_quad_tree
      # @return [Array] every intersecting rect
      def find_all_intersect_rect_quad_tree needle, quad_tree; end

      # Collisions within `rects`. When A and B intersect, the result has
      # both `A => B` and `B => A`. Only the first collision per rect is found.
      #
      # @param rects [Array<Typing::Rect, Object>]
      # @return [Hash{Object => Object}]
      def find_collisions rects; end

      # Calls the block with each intersecting pair of rects. With one
      # collection, checks it against itself.
      #
      # @example
      #   Geometry.each_intersect_rect(players, bullets, using: :hitbox) do |player, bullet|
      #     player.hp -= 1
      #   end
      #
      # @param rects_1 [Array<Typing::Rect, Object>, Typing::Rect, Object]
      # @param rects_2 [Array<Typing::Rect, Object>, Typing::Rect, Object, nil] should be the larger collection
      # @param tolerance [Float]
      # @param using [Symbol, Proc, nil] method or lambda that returns each object's rect
      # @yieldparam rect_1 [Object]
      # @yieldparam rect_2 [Object]
      # @return [void]
      def each_intersect_rect rects_1, rects_2 = nil, tolerance = 0.1, using: nil, &block; end

      # The next rect in `rects` in a direction from `rect`, for moving a
      # selection with a keyboard or controller.
      #
      # @example
      #   selected = Geometry.rect_navigate(rect: selected, rects: buttons,
      #                                     left_right: inputs.key_down.left_right,
      #                                     up_down: inputs.key_down.up_down)
      #
      # @param rect [Typing::Rect, Object] the current selection
      # @param rects [Array<Typing::Rect, Object>]
      # @param left_right [Integer, nil] `-1`, `0`, or `1`
      # @param up_down [Integer, nil] `-1`, `0`, or `1`
      # @param directional_vector [Typing::Point, Object, nil] used instead of `left_right` and `up_down`
      # @param wrap_x [Boolean] wrap around horizontally
      # @param wrap_y [Boolean] wrap around vertically
      # @param using [Symbol, Proc, nil] method or lambda that returns each object's rect
      # @return [Object] the newly selected element of `rects` (or `rect`)
      def rect_navigate rect:, rects:, left_right: nil, up_down: nil, directional_vector: nil, wrap_x: true, wrap_y: true, using: nil; end

      # @param rect [Typing::Rect, Object]
      # @return [Array<Typing::LineHash>] the edges of `rect`: bottom, right, top, left
      def rect_to_lines rect; end

      # @param line [Typing::Line, Object]
      # @return [Array(Typing::PointHash, Typing::PointHash)] the start and end points of `line`
      def line_to_points line; end

      # `x`, `y`, `w`, `h` and `center` of `rect`, with anchors applied.
      #
      # @param rect [Typing::Rect, Object]
      # @return [Typing::RectPropsHash]
      def rect_props rect; end

      # A copy of `rect` resized around its center, by ratio (`ratio:`,
      # `w_ratio:`, `h_ratio:`) or by pixels (`px:`, `w_px:`, `h_px:`), not both.
      #
      # @param rect [Typing::Rect, Object]
      # @param ratio [Numeric, nil]
      # @param w_ratio [Numeric, nil] overrides `ratio` for the width
      # @param h_ratio [Numeric, nil] overrides `ratio` for the height
      # @param px [Numeric, nil]
      # @param w_px [Numeric, nil] overrides `px` for the width
      # @param h_px [Numeric, nil] overrides `px` for the height
      # @return [Typing::RectPropsHash]
      def zoom_rect rect:, ratio: nil, w_ratio: nil, h_ratio: nil, px: nil, w_px: nil, h_px: nil; end

      # Linear interpolation from one rect to another.
      #
      # @param from [Typing::Rect, Object]
      # @param to [Typing::Rect, Object]
      # @param step [Numeric] `0.0` returns `from`, `1.0` returns `to`
      # @param tolerance [Numeric]
      # @return [Typing::RectPropsHash]
      def lerp_rect from, to, step, tolerance: 0; end
    end
  end
end

module Typing
  # phantom type for the Geometry functions DragonRuby mixes into Hash, Array and entities
  module GeometryMixin
    # @param other [Typing::Rect, Object] a rect
    # @param tolerance [Float]
    # @return [Boolean]
    def intersect_rect? other, tolerance = 0.1; end

    # @param other [Typing::Rect, Object] a rect
    # @return [Boolean] true if self is inside `other`
    def inside_rect? other; end

    # @param ratio [Float]
    # @return [Typing::RectHash] a scaled copy of self
    def scale_rect ratio, anchor_x = 0, anchor_y = 0; end

    # @param other [Typing::Point, Object] a point
    # @return [Float] angle in degrees from self to `other`
    def angle_to other; end

    # @param other [Typing::Point, Object] a point
    # @return [Float] angle in degrees from `other` to self
    def angle_from other; end

    # @param circle_center [Typing::Point, Object] a point
    # @param circle_radius [Numeric]
    # @return [Boolean]
    def point_inside_circle? circle_center, circle_radius; end

    # @param other [Typing::Rect, Object] a rect
    # @return [Typing::RectHash] self centered inside `other`
    def center_inside_rect other; end

    # @param other [Typing::Rect, Object] a rect
    # @return [Typing::RectHash] self centered horizontally inside `other`
    def center_inside_rect_x other; end

    # @param other [Typing::Rect, Object] a rect
    # @return [Typing::RectHash] self centered vertically inside `other`
    def center_inside_rect_y other; end

    # @param anchor_x [Float]
    # @param anchor_y [Float]
    # @return [Typing::RectHash] a new rect anchored by `anchor_x` and `anchor_y`
    def anchor_rect anchor_x, anchor_y; end

    # @return [Typing::PointHash] `x`, `y` center point of self
    def rect_center_point; end

    # @return [Typing::RectHash] bounding rect of self as a line
    def line_to_rect min_w: 0, min_h: 0; end

    # @return [Typing::LineHash] `x`, `y`, `x2`, `y2` diagonal of self as a rect
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
