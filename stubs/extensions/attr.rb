# Class macros from dragon/attr_dr.rb, attr_sprite.rb and attr_label.rb.
# Each one includes a module into the class it's called in. The plugin's
# Convention#local adds those includes for calls in your game's code, so the
# module methods complete on `self` and on instances.

class ::Module
  # Class macro that includes AttrDR, adding DragonRuby's environment methods
  # (`args`, `state`, `inputs`, `outputs`, `audio`, `grid`, `events`, ...) to
  # instances of the class, so `args` doesn't have to be passed around. Set
  # `instance.args = args` before using them.
  #
  # @return [void]
  def attr_dr; end

  # Older name for #attr_dr.
  # @return [void]
  def attr_gtk; end

  # Class macro that includes AttrSprite, so instances can be pushed into
  # `args.outputs.sprites` (or `args.outputs.primitives`) directly.
  #
  # @return [void]
  def attr_sprite; end

  # Class macro that includes AttrRect: `left`/`right`/`top`/`bottom` and the
  # Geometry functions, for a class that defines `x`, `y`, `w` and `h`.
  #
  # @return [void]
  def attr_rect; end

  # Class macro that includes AttrLabel, adding accessors for the label
  # properties (`x`, `y`, `text`, `size_px`, `font`, ...).
  #
  # @return [void]
  def attr_label; end
end

# Added to a class by `attr_dr` (or `attr_gtk`). Every method reads from
# `args`, which must be assigned first.
module AttrDR
  # @return [GTK::Args]
  attr_accessor :args

  # Same as `args.inputs.keyboard`.
  # @return [GTK::Keyboard]
  def keyboard; end

  # Same as `args.grid`.
  # @return [GTK::Grid]
  def grid; end

  # Same as `args.state`.
  # @return [GTK::OpenEntity]
  def state; end

  # Same as `args.temp_state`, which is cleared every tick.
  # @return [GTK::OpenEntity]
  def temp_state; end

  # Same as `args.inputs`.
  # @return [GTK::Inputs]
  def inputs; end

  # Same as `args.outputs`.
  # @return [GTK::Outputs]
  def outputs; end

  # Same as `args.gtk`.
  # @return [GTK::Runtime]
  def gtk; end

  # Same as `args.passes`.
  # @return [Array]
  def passes; end

  # Same as `args.pixel_arrays`.
  # @return [Hash{Symbol => GTK::PixelArray}]
  def pixel_arrays; end

  # Same as `args.geometry`.
  # @return [Module<GTK::Geometry>]
  def geometry; end

  # Same as `args.layout`.
  # @return [Module<GTK::Layout>]
  def layout; end

  # Same as `args.easing`.
  # @return [Module<GTK::Easing>]
  def easing; end

  # Same as `args.audio`.
  # @return [Hash]
  def audio; end

  # Same as `args.events`.
  # @return [GTK::Events]
  def events; end

  # Same as `args.cvars`.
  # @return [Hash]
  def cvars; end

  # Same as `state.new_entity`.
  #
  # @param entity_type [Symbol]
  # @param init_hash [Hash, nil] initial property values
  # @yieldparam entity [GTK::OpenEntity]
  # @return [GTK::OpenEntity]
  def new_entity entity_type, init_hash = nil, &block; end

  # Same as `state.new_entity_strict`.
  #
  # @param entity_type [Symbol]
  # @param init_hash [Hash, nil] the allowed properties and their initial values
  # @yieldparam entity [GTK::StrictEntity]
  # @return [GTK::StrictEntity]
  def new_entity_strict entity_type, init_hash = nil, &block; end

  # Same as `Kernel.tick_count`.
  # @return [Integer]
  def tick_count; end

  # Same as `Kernel.global_tick_count`.
  # @return [Integer]
  def global_tick_count; end
end

# Older name for AttrDR.
AttrGTK = AttrDR

# Added to a class by `attr_rect` (and by `attr_sprite`). Expects the class to
# respond to `x`, `y`, `w` and `h`.
module AttrRect
  include Typing::GeometryMixin

  # @return [Numeric] same as `x`
  def left; end

  # @return [Numeric] `x + w`
  def right; end

  # @return [Numeric] same as `y`
  def bottom; end

  # @return [Numeric] `y + h`
  def top; end

  # @return [Numeric] same as `x`
  def x1; end

  # @return [Numeric] same as `y`
  def y1; end
end

# Added to a class by `attr_sprite`. Instances render as sprites.
module AttrSprite
  include AttrRect

  # @return [Numeric]
  attr_accessor :x, :y, :w, :h, :z, :angle, :angle_x, :angle_y,
    :angle_anchor_x, :angle_anchor_y, :anchor_x, :anchor_y,
    :tile_x, :tile_y, :tile_w, :tile_h,
    :source_x, :source_y, :source_w, :source_h,
    :x2, :y2, :x3, :y3, :source_x2, :source_y2, :source_x3, :source_y3

  # @return [Integer] 0-255
  attr_accessor :r, :g, :b, :a, :r2, :g2, :b2, :a2, :r3, :g3, :b3, :a3

  # @return [String, Symbol] image file path, or a render target name
  attr_accessor :path

  # @return [Boolean]
  attr_accessor :flip_horizontally, :flip_vertically

  # @return [Integer]
  attr_accessor :blendmode_enum, :scale_quality_enum

  # @return [Symbol, Integer]
  attr_accessor :blendmode

  # @return [Object]
  attr_accessor :id

  # @return [Symbol] always `:sprite`
  def primitive_marker; end

  # @return [self]
  def sprite; end

  # @param value [Numeric]
  # @return [void]
  def x1= value; end

  # @param value [Numeric]
  # @return [void]
  def y1= value; end

  # @return [Hash] the sprite properties
  def serialize; end
end

# Added to a class by `attr_label`.
module AttrLabel
  # @return [Numeric]
  attr_accessor :x, :y, :z, :anchor_x, :anchor_y, :size_px

  # @return [String]
  attr_accessor :text

  # @return [Integer]
  attr_accessor :size_enum, :alignment_enum, :vertical_alignment_enum, :blendmode_enum

  # @return [Integer] 0-255
  attr_accessor :r, :g, :b, :a

  # @return [String] font file path
  attr_accessor :font
end
