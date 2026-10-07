## [Unreleased]

## [0.1.0] - 2026-10-07

- Initial release: Solargraph plugin (`plugins: [solargraph-dragonruby]`) that adds DragonRuby API pins.
- Vendors the YARD stubs from owenbutler/dragonruby-yard-doc @ 06cc3d1 (`rake stubs:sync` to update).
- Adds coverage for `args.state`/entities, `Grid`, `DR`, events, pixel arrays, keyboard/controller/mouse
  details, `vec2_*` and other Geometry functions, the Geometry mixin on Hash/Array, and Numeric/Array/Layout helpers.
- Requires Solargraph 0.61.x.
