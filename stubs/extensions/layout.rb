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
    end
  end
end
