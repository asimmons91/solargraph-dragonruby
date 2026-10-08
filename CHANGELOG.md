## [Unreleased]

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
