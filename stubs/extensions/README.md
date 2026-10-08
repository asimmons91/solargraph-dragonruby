# Extensions

YARD stubs for DragonRuby APIs that the vendored upstream stubs
(`../upstream`, synced from owenbutler/dragonruby-yard-doc) do not cover yet.

- Written against the DragonRuby 7.22 Pro SDK: the docs (`docs/api/*.md`),
  the sample apps, and the open-source runtime (`docs/oss/dragon/*.rb`).
  When they disagree, the runtime source and samples win. For example, the
  docs still describe `outputs.shader_path`/`shader_tex1`, which no longer exist.
- Indie/Pro-only APIs say so in their doc comment ("Indie or Pro license." /
  "Pro license.").
- These files reopen upstream classes. If one re-declares a method that
  upstream already defines, the upstream pin is dropped (see
  `Solargraph::Dragonruby::Convention.pins`), so the definition here wins.
- `rake stubs:sync` never touches this directory.
- Hashes with a known shape use the phantom types in `typing.rb`: return
  `Typing::PointHash`, `Typing::RectHash`, ... (they subclass Hash), and type
  shape parameters as `[Typing::Point, Object]`, `[Typing::Rect, Object]`, ...
  Keep `Object` in parameter types: with only the phantom type,
  `solargraph typecheck --level strict` rejects plain Hashes.
