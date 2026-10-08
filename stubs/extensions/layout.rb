module GTK
  class Layout
    class << self
      # @return [Integer] rows in the layout grid (`12` landscape, `24` portrait)
      def row_count; end

      # @return [Integer] maximum row index
      def row_max_index; end

      # @return [Integer] columns in the layout grid (`24` landscape, `12` portrait)
      def col_count; end

      # @return [Integer] maximum column index
      def col_max_index; end

      # Same as `Layout.rect(..., allscreen: true)`: the returned rect is
      # aligned to `Grid.allscreen_rect` instead of the 16:9 safe area. Useful
      # for layouts in render targets with `hd_letterbox=false`.
      #
      # Pro license (All Screen mode).
      #
      # @param row [Integer, Array(Integer, Integer)]
      # @param col [Integer, Array(Integer, Integer)]
      # @param w [Integer]
      # @param h [Integer]
      # @return [Typing::RectPropsHash] `x`, `y`, `w`, `h`, and `center` (a Hash with `x`, `y`)
      def allscreen_rect row: 0, col: 0, w: 1, h: 1, **opts; end

      # The rect of a cell span on the virtual grid (12 rows by 24 columns, or
      # 24 by 12 in portrait), within the safe area.
      #
      # @example
      #   Layout.rect(row: 1, col: 10, w: 4, h: 2)
      #   Layout.rect(row: 0, col: [3, -3])   # columns 3 through the third from the right
      #
      # @param row [Numeric, Array(Integer, Integer)] row, or a `[from, to]` range (`to <= 0` counts from the end)
      # @param col [Numeric, Array(Integer, Integer)] column, or a `[from, to]` range
      # @param w [Numeric] width in cells
      # @param h [Numeric] height in cells
      # @param row_from_bottom [Numeric, nil] row counted from the bottom, instead of `row`
      # @param col_from_right [Numeric, nil] column counted from the right, instead of `col`
      # @param max_width [Numeric, nil]
      # @param max_height [Numeric, nil]
      # @param dx [Numeric] added to `x`
      # @param dy [Numeric] added to `y`
      # @param include_row_gutter [Boolean]
      # @param include_col_gutter [Boolean]
      # @param include_gutter [Boolean] both gutters
      # @param merge [Hash, nil] merged into the result
      # @param origin [Symbol]
      # @param safe_area [Boolean]
      # @param allscreen [Boolean] align to `Grid.allscreen_rect` (Pro license, All Screen mode)
      # @return [Typing::RectPropsHash] `x`, `y`, `w`, `h`, and `center` (a Hash with `x`, `y`)
      def rect row: 0, col: 0, w: 1, h: 1, row_from_bottom: nil, col_from_right: nil, max_width: nil, max_height: nil, dx: 0, dy: 0, include_row_gutter: false, include_col_gutter: false, include_gutter: false, merge: nil, origin: :top_left, safe_area: true, allscreen: false; end

      # Lays out `items` one after another, wrapping at the edge of the grid.
      # Each result is the item's rect merged with `item:` and `layout:`.
      # An item may carry its own `rect_args` (`w`, `h`, gutters).
      #
      # @param items [Array]
      # @param direction [Symbol] `:row` (left to right) or `:col` (top to bottom)
      # @param row [Numeric] starting row
      # @param col [Numeric] starting column
      # @param w [Numeric] width of each item in cells
      # @param h [Numeric] height of each item in cells
      # @param include_row_gutter [Boolean]
      # @param include_col_gutter [Boolean]
      # @return [Array<Typing::RectPropsHash>]
      def rects items, direction: :row, row: 0, col: 0, w: 1, h: 1, include_row_gutter: false, include_col_gutter: false; end

      # Lays out each Hash in `group:` starting at `row:`/`col:` (or
      # `row_from_bottom:`/`col_from_right:`), stepping by `drow:`/`dcol:`.
      # Each result is the rect merged with the item (labels honor
      # `alignment_enum`).
      #
      # @example
      #   Layout.rect_group(row: 0, col: 0, drow: 0.5, group: [{ text: "a" }, { text: "b" }])
      #
      # @param group [Array<Hash>] items to lay out; each may have its own `layout:` rect options
      # @param row [Numeric, nil] starting row
      # @param col [Numeric, nil] starting column
      # @param row_from_bottom [Numeric, nil] starting row counted from the bottom
      # @param col_from_right [Numeric, nil] starting column counted from the right
      # @param drow [Numeric] rows to move for each item
      # @param dcol [Numeric] columns to move for each item
      # @param w [Numeric] width of each item in cells
      # @param h [Numeric] height of each item in cells
      # @param merge [Hash, nil] merged into every result
      # @param row_offset [Hash, nil] `count:` (and `h:`) of items to center vertically
      # @param col_offset [Hash, nil] `count:` (and `w:`) of items to center horizontally
      # @return [Array<Typing::RectPropsHash>]
      def rect_group group:, row: nil, col: nil, row_from_bottom: nil, col_from_right: nil, drow: 0, dcol: 0, w: 0, h: 0, merge: nil, row_offset: nil, col_offset: nil; end

      # A point inside a cell. `row_anchor:`/`col_anchor:` (`0.0` to `1.0`)
      # pick where in the cell; the default is the cell's bottom left.
      #
      # @example
      #   Layout.point(row: 7, col: 5.5, row_anchor: 0.5, col_anchor: 0.5)
      #
      # @param row [Numeric]
      # @param col [Numeric]
      # @param row_anchor [Float, nil] `0.0` (bottom) to `1.0` (top) of the cell
      # @param col_anchor [Float, nil] `0.0` (left) to `1.0` (right) of the cell
      # @param rect_options [Hash] other #rect options
      # @return [Typing::RectPropsHash]
      def point row: 0, col: 0, row_anchor: nil, col_anchor: nil, **rect_options; end

      # @param reference [Typing::Rect, Object] rect to take the size from
      # @param target [Typing::Rect, Object] rect to center on
      # @return [Typing::RectHash] a rect the size of `reference` centered on `target`
      def rect_center reference, target; end

      # @param n [Numeric]
      # @return [Numeric] width of `n` columns
      def w n; end

      # @param n [Numeric]
      # @return [Numeric] height of `n` rows
      def h n; end

      # @return [Numeric] space between cells
      def gutter; end

      # @return [Numeric] size of a cell (cells are square)
      def cell_size; end

      # @return [Numeric] same as #cell_size
      def cell_width; end

      # @return [Numeric] same as #cell_size
      def cell_height; end

      # @return [Typing::RectHash] `x`, `y`, `w`, `h` of the area inside the outer gutters
      def control_rect; end

      # @return [Typing::RectHash] `x`, `y`, `w`, `h` of the safe area
      def safe_rect; end

      # @return [Typing::RectHash] `x`, `y`, `w`, `h` of the logical canvas
      def logical_rect; end

      # @return [Symbol] `:landscape` or `:portrait`
      def orientation; end

      # @return [Numeric] font size in points that fills a cell's height
      def font_size_cell; end

      # @return [Numeric] same as #font_size_cell
      def font_size_xl; end

      # @return [Numeric] 80% of #font_size_cell
      def font_size_lg; end

      # @return [Numeric] 70% of #font_size_cell
      def font_size_med; end

      # @return [Numeric] same as #font_size_med
      def font_size; end

      # @return [Numeric] 60% of #font_size_cell
      def font_size_sm; end

      # @return [Numeric] 50% of #font_size_cell
      def font_size_xs; end

      # @param px [Numeric]
      # @return [Integer] `px` in points
      def font_px_to_pt px; end

      # @param pt [Numeric]
      # @return [Numeric] `pt` in pixels
      def font_pt_to_px pt; end
    end
  end
end
