## [Unreleased]

- Add Indie/Pro APIs: `outputs.shader`, `DR.get_dlopen_path`, `DR.start_text_input`/`stop_text_input`,
  `args.inputs.http_requests` (with `HTTPRequest#respond`/`reject`), and `Layout.allscreen_rect`.
- Note the required license tier in the docs of Indie/Pro APIs, including upstream's `dlopen` and HD functions
  and `Grid`'s all-screen, pixel-category and scale properties.
- Fix `buffered_click`/`buffered_held` to return a `MousePoint` (DragonRuby 7.22); add them on `Mouse` and add `MousePoint#x`/`#y`.
- Fix `args.inputs.text` to return `Array<String>`.

## [0.1.0] - 2026-10-07

- Initial release: Solargraph plugin (`plugins: [solargraph-dragonruby]`) that adds DragonRuby API pins.
- Vendors the YARD stubs from owenbutler/dragonruby-yard-doc @ 06cc3d1 (`rake stubs:sync` to update).
- Adds coverage for `args.state`/entities, `Grid`, `DR`, events, pixel arrays, keyboard/controller/mouse
  details, `vec2_*` and other Geometry functions, the Geometry mixin on Hash/Array, and Numeric/Array/Layout helpers.
- Requires Solargraph 0.61.x.
