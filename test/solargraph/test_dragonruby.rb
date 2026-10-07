# frozen_string_literal: true

require "test_helper"

class Solargraph::TestDragonruby < Minitest::Test
  Convention = Solargraph::Dragonruby::Convention

  # Building an ApiMap loads Ruby's core pins, so share one across tests and
  # re-map the game source per test. The plugin's pins only arrive on catalog,
  # so catalog up front for tests that query the map without mapping a source.
  def self.api_map
    @api_map ||= Solargraph::ApiMap.new.catalog(Solargraph::Bench.new)
  end

  # Completes `expr` (with the cursor at its end) inside `def tick args`.
  # Uses partial identifiers: a bare ApiMap has no live repair for a trailing ".".
  def complete(expr)
    source = Solargraph::Source.load_string("def tick args\n  #{expr}\nend\n", "main.rb")
    api = self.class.api_map
    api.map(source)
    api.clip_at("main.rb", [1, expr.length + 2]).complete.pins.map(&:name)
  end

  # Like #complete, but inside a hook defined in `module Main`.
  def complete_in_main(expr, signature: "def tick")
    source = Solargraph::Source.load_string("module Main\n  #{signature}\n    #{expr}\n  end\nend\n", "main.rb")
    api = self.class.api_map
    api.map(source)
    api.clip_at("main.rb", [2, expr.length + 4]).complete.pins.map(&:name)
  end

  # Like #complete, but inside an instance method of a class whose body is `body`.
  def complete_in_class(expr, body:)
    source = Solargraph::Source.load_string("class Player\n  #{body}\n  def update\n    #{expr}\n  end\nend\n", "player.rb")
    api = self.class.api_map
    api.map(source)
    api.clip_at("player.rb", [3, expr.length + 4]).complete.pins.map(&:name)
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

  def test_buffered_click_returns_mouse_point
    assert_includes complete("args.inputs.mouse.buttons.left.buffered_click.created_"), "created_at"
    assert_includes complete("args.inputs.mouse.buffered_held.glob"), "global_created_at"
    assert_includes complete("args.inputs.mouse.buttons.right.buffered_click.inside_"), "inside_rect?"
  end

  # module Main

  def test_main_helpers
    {"outp" => "outputs", "inpu" => "inputs", "stat" => "state", "even" => "events", "aud" => "audio"}.each do |expr, name|
      assert_includes complete_in_main(expr), name
    end
  end

  def test_main_helper_chains
    assert_includes complete_in_main("inputs.keyboard.key_d"), "key_down"
    assert_includes complete_in_main("outputs.spr"), "sprites"
    assert_includes complete_in_main("args.outp"), "outputs"
  end

  def test_main_tick_args_is_inferred_as_gtk_args
    source = Solargraph::Source.load_string("module Main\n  def tick args\n    args.outputs\n  end\nend\n", "main.rb")
    api = self.class.api_map
    api.map(source)
    assert_equal "GTK::Outputs", api.clip_at("main.rb", [2, 10]).define.first.return_type.to_s
  end

  def test_main_hooks
    assert_includes complete_in_main("stat", signature: "def start"), "state"
    assert_includes complete_in_main("args.outp", signature: "def boot args"), "outputs"
  end

  def test_main_state_is_a_hash
    assert_includes complete_in_main("state.fetc"), "fetch"
    refute_includes complete_in_main("state.new_ent"), "new_entity"
  end

  def test_main_helpers_stay_in_main
    refute_includes complete("outp"), "outputs"
  end

  # class macros

  def test_attr_dr_adds_environment_methods
    assert_includes complete_in_class("outp", body: "attr_dr"), "outputs"
    assert_includes complete_in_class("inputs.keyboard.key_d", body: "attr_dr"), "key_down"
    assert_includes complete_in_class("state.new_ent", body: "attr_dr"), "new_entity"
    assert_includes complete_in_class("geometry.inter", body: "attr_dr"), "intersect_rect?"
  end

  def test_attr_gtk_is_an_alias
    assert_includes complete_in_class("outp", body: "attr_gtk"), "outputs"
  end

  def test_attr_sprite_adds_sprite_and_rect_methods
    {"self.pat" => "path", "self.flip_h" => "flip_horizontally", "self.rig" => "right",
     "self.intersect_" => "intersect_rect?"}.each do |expr, name|
      assert_includes complete_in_class(expr, body: "attr_sprite"), name
    end
  end

  def test_attr_sprite_completes_on_instances
    source = Solargraph::Source.load_string("class Ship\n  attr_sprite\nend\nShip.new.pat\n", "ship.rb")
    api = self.class.api_map
    api.map(source)
    assert_includes api.clip_at("ship.rb", [3, 12]).complete.pins.map(&:name), "path"
  end

  def test_attr_label_and_attr_rect
    assert_includes complete_in_class("self.size_", body: "attr_label"), "size_px"
    assert_includes complete_in_class("self.bott", body: "attr_rect"), "bottom"
  end

  def test_macro_called_in_an_instance_method
    source = Solargraph::Source.load_string("class Game\n  def initialize\n    attr_dr\n  end\n  def tick\n    outp\n  end\nend\n", "game.rb")
    api = self.class.api_map
    api.map(source)
    assert_includes api.clip_at("game.rb", [5, 8]).complete.pins.map(&:name), "outputs"
  end

  def test_macros_only_affect_their_class
    refute_includes complete_in_class("outp", body: "attr_reader :hp"), "outputs"
  end

  # Indie and Pro

  def test_shader
    assert_includes complete("args.outputs.shad"), "shader"
    assert_includes complete("args.outputs[:rt].shad"), "shader"
  end

  def test_pro_runtime_functions
    names = complete("DR.st")
    assert_includes names, "start_text_input"
    assert_includes names, "stop_text_input"
    assert_includes complete("DR.get_dl"), "get_dlopen_path"
  end

  def test_http_requests
    assert_includes complete("args.inputs.http_requests.first.resp"), "respond"
  end

  def test_layout_allscreen_rect
    assert_includes complete("Layout.allscreen_"), "allscreen_rect"
  end

  def test_tier_notes_replace_upstream_docs
    %w[dlopen set_hd_max_scale set_hd_letterbox toggle_hd_letterbox].each do |name|
      stack = self.class.api_map.get_method_stack("GTK::Runtime", name)
      assert_equal 1, stack.length, name
      assert_match(/Pro license/, stack.first.docstring.to_s, name)
    end
  end

  def test_inputs_text_returns_string_array
    stack = self.class.api_map.get_method_stack("GTK::Inputs", "text")
    assert_equal ["Array<String>"], stack.map { |pin| pin.return_type.to_s }
  end
end
