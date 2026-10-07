# frozen_string_literal: true

require "test_helper"

class Solargraph::TestDragonruby < Minitest::Test
  Convention = Solargraph::Dragonruby::Convention

  # Building an ApiMap loads Ruby's core pins, so share one across tests and
  # re-map the game source per test.
  def self.api_map
    @api_map ||= Solargraph::ApiMap.new
  end

  # Completes `expr` (with the cursor at its end) inside `def tick args`.
  # Uses partial identifiers: a bare ApiMap has no live repair for a trailing ".".
  def complete(expr)
    source = Solargraph::Source.load_string("def tick args\n  #{expr}\nend\n", "main.rb")
    api = self.class.api_map
    api.map(source)
    api.clip_at("main.rb", [1, expr.length + 2]).complete.pins.map(&:name)
  end

  def test_that_it_has_a_version_number
    refute_nil ::Solargraph::Dragonruby::VERSION
  end

  def test_plugin_entry_point_registers_convention
    require "solargraph-dragonruby"
    conventions = Solargraph::Convention.class_variable_get(:@@conventions)
    assert conventions.any? { |c| c.is_a?(Convention) }
  end

  def test_every_stub_file_produces_pins
    stubs = Dir[File.join(Convention::STUBS_DIR, "{upstream,extensions}", "*.rb")]
    refute_empty stubs
    stubs.each do |path|
      refute_empty Solargraph::SourceMap.load(path).all_pins, "#{path} produced no pins"
    end
  end

  def test_pins_are_memoized
    assert_same Convention.pins, Convention.pins
  end

  def test_global_returns_the_same_pin_objects_every_catalog
    first = Convention.new.global(nil).pins
    second = Convention.new.global(nil).pins
    refute_same first, second
    assert first.zip(second).all? { |a, b| a.equal?(b) }
  end

  def test_extensions_replace_upstream_methods_they_redeclare
    stack = self.class.api_map.get_method_stack("GTK::Keyboard", "key_down")
    assert_equal 1, stack.length
    assert_equal "GTK::KeyboardKeys", stack.first.return_type.to_s
  end

  def test_tick_args_is_inferred_as_gtk_args
    source = Solargraph::Source.load_string("def tick args\n  args.outputs\nend\n", "main.rb")
    api = self.class.api_map
    api.map(source)
    assert_equal "GTK::Outputs", api.clip_at("main.rb", [1, 8]).define.first.return_type.to_s
  end

  # upstream coverage

  def test_outputs
    assert_includes complete("args.outputs.spr"), "sprites"
  end

  def test_inputs
    assert_includes complete("args.inputs.keyboard.key_d"), "key_down"
  end

  def test_args_geometry
    assert_includes complete("args.geometry.inter"), "intersect_rect?"
  end

  def test_gtk_global
    assert_includes complete("$gtk.set_window_t"), "set_window_title"
  end

  def test_geometry_constant
    assert_includes complete("Geometry.dist"), "distance"
  end

  def test_kernel_tick_count
    assert_includes complete("Kernel.tick_c"), "tick_count"
  end

  # extensions

  def test_state
    assert_includes complete("args.state.new_ent"), "new_entity"
    assert_includes complete("args.state.new_entity(:enemy).created_at_el"), "created_at_elapsed"
  end

  def test_grid
    assert_includes complete("args.grid.allscreen_"), "allscreen_rect"
    assert_includes complete("Grid.orient"), "orientation"
    assert_includes complete("$grid.w_p"), "w_px"
  end

  def test_events_and_pixel_arrays
    assert_includes complete("args.events.resize_"), "resize_occurred"
    assert_includes complete("args.pixel_array(:p).pix"), "pixels"
  end

  def test_runtime
    assert_includes complete("DR.read_save_"), "read_save_data"
    assert_includes complete("DR.notif"), "notify!" # upstream method via the new constant
    assert_includes complete("Kernel.global_tick_c"), "global_tick_count"
  end

  def test_keyboard_keys
    assert_includes complete("args.inputs.keyboard.key_down.spa"), "space"
    assert_includes complete("args.inputs.keyboard.key_held.truthy_"), "truthy_keys"
    assert_includes complete("args.inputs.keyboard.directional_vector_w"), "directional_vector_wasd"
  end

  def test_controller
    assert_includes complete("args.inputs.controller_one.key_down.sou"), "south"
    assert_includes complete("args.inputs.controller_one.acc"), "accept"
  end

  def test_mouse_buttons
    assert_includes complete("args.inputs.mouse.buttons.left.buffered_"), "buffered_click"
  end

  def test_geometry_functions_and_mixin
    assert_includes complete("Geometry.vec2_norm"), "vec2_normalize"
    assert_includes complete("{ x: 0, y: 0, w: 1, h: 1 }.intersect_"), "intersect_rect?"
  end

  def test_core_extensions
    assert_includes complete("0.frame_ind"), "frame_index"
    assert_includes complete("[[1]].map_2"), "map_2d"
    assert_includes complete("Layout.row_c"), "row_count"
  end

  def test_outputs_watch
    assert_includes complete("args.outputs.debug.wat"), "watch"
  end
end
