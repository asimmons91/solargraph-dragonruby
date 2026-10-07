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
      # @return [Hash] `x`, `y`, `w`, `h`, and `center` (a Hash with `x`, `y`)
      def allscreen_rect row: 0, col: 0, w: 1, h: 1, **opts; end
    end
  end
end
