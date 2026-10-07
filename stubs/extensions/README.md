# Extensions

YARD stubs for DragonRuby APIs that the vendored upstream stubs
(`../upstream`, synced from owenbutler/dragonruby-yard-doc) do not cover yet.

- Written against the DragonRuby 7.21 docs (`docs/api/*.md` in the SDK) and
  the bundled sample apps.
- These files reopen upstream classes. If one re-declares a method that
  upstream already defines, the upstream pin is dropped (see
  `Solargraph::Dragonruby::Convention.pins`), so the definition here wins.
- `rake stubs:sync` never touches this directory.
