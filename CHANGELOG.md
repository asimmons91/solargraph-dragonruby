## [Unreleased]

## [0.2.0] - 2026-10-08

- Adds `module Main` support: the `boot`/`start`/`tick`/`reset`/`did_reset`/`shutdown` hooks type `args` as
  `GTK::Args` when they take it, and `args`, `inputs`, `outputs`, `state` (a `Hash`), `events` and `audio`
  complete as bare calls inside `Main`.
- Adds the `attr_dr`/`attr_gtk`, `attr_sprite`, `attr_rect`, `attr_label` and `attr_line` class macros: a call in a
  class body (or instance method) is treated as including `AttrDR`, `AttrSprite`, `AttrRect`, `AttrLabel` or `AttrLine`,
  so their methods complete on `self` and on instances.
- Adds documented APIs that were missing:
  - Inputs: mouse `key_down`/`key_held`/`key_up`, `rect`/`point` (with `offset:`), the combined keyboard or controller
    `args.inputs.key_down`/`key_held`/`key_up`, `left_right_dpad`/`left_right_perc_dpad`/`up_down_arrow` and the other
    top-level aliases, `Keyboard#directional_vector`/`directional_angle`, and `args.inputs.touch` values (`FingerTouch`)
  - Keyboard keys: `f1`–`f12`, the numpad, `home`/`end`/`page_up`/`page_down`/`insert`, `caps_lock`, and more symbols
  - `Easing.spline`, `Numeric.compose_blendmode` and the `BLENDFACTOR_*`/`BLENDOPERATION_*` constants,
    `Numeric#mid?`/`between?`/`min`/`max` and `Numeric.mid`, `args.audio.volume`, and `Zlib`
- Fixes the signatures of `Easing.smooth_start`/`smooth_stop`/`smooth_step` (keyword arguments) and `Numeric#mid`.
- Adds undocumented APIs that the runtime and sample apps use:
  - Numeric: `randomize`, `rand_sign`, `half`, `to_vector`, `towards`, `from_right`/`from_left`/`from_bottom`,
    `sin`/`cos`/`tan` (and `_d`/`_r`), `ease`/`ease_spline`, `to_sf(decimal_places:, include_sign:)`, ...
  - `Grid.x`/`y`/`center`/`w_half`/`h_half`, `origin_center?`, `letterbox?`, `hd?` and more pixel-category properties
  - `Layout.rect_group`, `rects`, `point`, `rect_center`, `font_size_*`, `safe_rect`, ...
  - `Geometry.line_slope`, `line_length`, `line_rect`, `rect_to_line`, `cubic_bezier`, `circle?`, ...
  - Inputs: `directional_vector`/`directional_angle` (on inputs, keyboard key states and controllers), more mouse
    properties (`position`, `held`, `left`, `click_at`, `key_down?`, ...), `finger_one`/`finger_two`, `pinch_zoom`
  - `String#wrapped_lines`, `String.line_anchors`, `trim`, ..., and the global `log_info`/`log_warn`/`log_once`/... functions
  - `DR.pause!`, `serialize_state`/`deserialize_state`, `set_rng`, `notify`, `http_head`/`http_put`, `platform`, ...,
    `outputs.render_target_state`, `outputs.a11y`, `watch_fps`, and `File.append`
- Fixes the `Layout.rect` signature (keyword arguments).
- Types the Hashes DragonRuby returns, so their fields complete (`Geometry.vec2_add(a, b).x`,
  `Layout.rect(...).center.x`, `DR.http_get(url).response_data`, ...): adds phantom `Typing::PointHash`, `RectHash`,
  `RectPropsHash`, `LineHash`, `CircleHash`, `ColorHash`, `SizeHash`, and record types for `Numeric#frame`, http
  responses, `DR.stat_file`, `keyboard.keys` and render target state. Shape parameters are documented as
  `[Typing::Rect, Object]` (and `Point`, `Line`, `Circle`), which still accepts any value.
- Types `MouseButton#click`/`down`/`held`/`up` as `MousePoint`, `Easing.ease` definitions as `Array<Symbol, Proc>`, and
  makes `Layout.rect_group`/`point` and `Numeric#to_layout_*` take keyword arguments.
- Fixes upstream Geometry docs: `line_intersect`/`ray_intersect` return types, mismatched parameter names, and the
  signatures of `inside_rect?`, `point_inside_circle?`, `rotate_point`, `rect_navigate`, `zoom_rect`, `line_to_points`, ...

## [0.1.0] - 2026-10-07

- Initial release: Solargraph plugin (`plugins: [solargraph-dragonruby]`) that adds DragonRuby API pins.
- Vendors the YARD stubs from owenbutler/dragonruby-yard-doc @ 06cc3d1 (`rake stubs:sync` to update).
- Adds coverage for `args.state`/entities, `Grid`, `DR`, events, pixel arrays, keyboard/controller/mouse
  details, `vec2_*` and other Geometry functions, the Geometry mixin on Hash/Array, and Numeric/Array/Layout helpers.
- Adds Indie/Pro APIs: `outputs.shader`, `DR.get_dlopen_path`, `DR.start_text_input`/`stop_text_input`,
  `args.inputs.http_requests` (with `HTTPRequest#respond`/`reject`), and `Layout.allscreen_rect`.
- Notes the required license tier in the docs of Indie/Pro APIs, including upstream's `dlopen` and HD functions
  and `Grid`'s all-screen, pixel-category and scale properties.
- Types `buffered_click`/`buffered_held` as `MousePoint` (DragonRuby 7.22), adds them on `Mouse` along with
  `MousePoint#x`/`#y`, and types `args.inputs.text` as `Array<String>`.
- Requires Solargraph 0.61.x.

[Unreleased]: https://github.com/asimmons91/solargraph-dragonruby/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/asimmons91/solargraph-dragonruby/compare/v0.1.0...v0.2.0
