module GTK
  # Information about the screen and game canvas. Use the global `Grid`
  # (or `$grid`/`args.grid`). Unless noted, values are in logical
  # (720p-scale) units and take `origin_name` and `orientation` into account.
  class Grid
    # @return [Symbol] `:landscape` (default) or `:portrait`, from `game_metadata.txt`
    def orientation; end

    # @return [Boolean] true on the frame the orientation changed (window resize or device rotation)
    def orientation_changed?; end

    # @return [Symbol] `:bottom_left` (default) or `:center`
    def origin_name; end

    # Sets the coordinate system so `0, 0` is the bottom-left corner.
    # @return [void]
    def origin_bottom_left!; end

    # Sets the coordinate system so `0, 0` is the center of the screen.
    # @return [void]
    def origin_center!; end

    # @return [Boolean] true if `orientation` is `:portrait`
    def portrait?; end

    # @return [Boolean] true if `orientation` is `:landscape`
    def landscape?; end

    # @return [Numeric] bottom of the grid (`0`, or `-360`/`-640` with a centered origin)
    def bottom; end

    # @return [Numeric] top of the grid
    def top; end

    # @return [Numeric] left of the grid
    def left; end

    # @return [Numeric] right of the grid
    def right; end

    # @return [Hash] a rect primitive (`x`, `y`, `w`, `h`) representing the grid
    def rect; end

    # @return [Numeric] the grid's width
    def w; end

    # @return [Numeric] the grid's height
    def h; end

    # @return [Integer] width component of the aspect ratio (`16` in landscape for the default 16:9)
    def aspect_ratio_w; end

    # @return [Integer] height component of the aspect ratio (`9` in landscape for the default 16:9)
    def aspect_ratio_h; end

    # @return [Integer] the `aspect_size` from `game_metadata.txt` (default `720`)
    def aspect_size; end

    # @!group All Screen (area outside the 16:9 safe area, when the window overflows it)

    # @return [Numeric]
    def allscreen_left; end
    # @return [Numeric]
    def allscreen_x; end
    # @return [Numeric]
    def allscreen_right; end
    # @return [Numeric]
    def allscreen_y; end
    # @return [Numeric]
    def allscreen_top; end
    # @return [Numeric]
    def allscreen_bottom; end
    # @return [Numeric]
    def allscreen_w; end
    # @return [Numeric]
    def allscreen_h; end
    # @return [Hash] rect covering the whole window
    def allscreen_rect; end
    # @return [Numeric]
    def allscreen_offset_x; end
    # @return [Numeric]
    def allscreen_offset_y; end
    # @return [Hash] `x`, `y` offsets of the safe area within the window
    def allscreen_offset; end

    # @!endgroup

    # @!group Pixel category (same as logical values on a Standard license)

    # @return [Numeric]
    def w_px; end
    # @return [Numeric]
    def h_px; end
    # @return [Numeric]
    def left_px; end
    # @return [Numeric]
    def right_px; end
    # @return [Numeric]
    def top_px; end
    # @return [Numeric]
    def bottom_px; end
    # @return [Numeric]
    def allscreen_left_px; end
    # @return [Numeric]
    def allscreen_right_px; end
    # @return [Numeric]
    def allscreen_top_px; end
    # @return [Numeric]
    def allscreen_bottom_px; end
    # @return [Numeric]
    def allscreen_offset_x_px; end
    # @return [Numeric]
    def allscreen_offset_y_px; end

    # @!endgroup

    # @return [Float] native scale of the window compared to 720p
    def native_scale; end

    # @return [Float] best-fit pixel-perfect render scale compared to 720p (see `hd_max_scale`)
    def render_scale; end

    # @return [Float] rendering scale for textures (720p: `1.0`, 1080p: `1.5`, 4k: `3.0`, ...)
    def texture_scale; end

    # @return [Integer] best-fit texture atlas scale (720p: `100`, 1080p: `150`, ...)
    def texture_scale_enum; end

    # @return [Integer] refresh rate of the current display
    def refresh_rate; end
  end
end

# @return [GTK::Grid]
Grid = GTK::Grid.new

# @type [GTK::Grid]
$grid = GTK::Grid.new
