# solargraph-dragonruby

A [Solargraph](https://solargraph.org) plugin that gives LSP editors autocomplete,
hover docs and go-to-definition for the [DragonRuby Game Toolkit](https://dragonruby.org) API:
`args.outputs`, `args.inputs`, `args.state`, `$gtk`/`DR`, `Grid`, `Geometry`, `Layout`, `Easing`, and more.

```ruby
def tick args                         # args is typed as GTK::Args automatically
  args.outputs.sprites << { ... }     # completes outputs, inputs, state, grid, events, ...
  if args.inputs.keyboard.key_down.space
    DR.notify! "jump"
  end
end
```

The API definitions are YARD stubs. Most of them come from
[owenbutler/dragonruby-yard-doc](https://github.com/owenbutler/dragonruby-yard-doc),
with extra coverage added here (see [What's covered](#whats-covered)).

## Requirements

- A CRuby install. DragonRuby doesn't need one, but Solargraph does.
- Solargraph 0.61.x: `gem install solargraph -v '~> 0.61.0'`
- An editor configured to use the Solargraph language server (see [Editor setup](#editor-setup))

## Installation

Install the gem into the same Ruby that runs `solargraph`:

```sh
gem install solargraph-dragonruby
```

Then create a `.solargraph.yml` in your game's root directory (`solargraph config` generates
a default one) and add the plugin:

```yml
include:
  - "mygame/app/**/*.rb"
plugins:
  - solargraph-dragonruby
```

Restart your editor's language server.

### Migrating from a dragonruby-yard-doc checkout

If your `.solargraph.yml` includes a cloned copy of the stubs (for example
`../dragonruby-yard-doc/*.rb`), remove that line. Otherwise every definition is
indexed twice.

## What's covered

- **From dragonruby-yard-doc** (`stubs/upstream`): `GTK::Args`, `GTK::Runtime` (`$gtk`, `$dr`),
  outputs, inputs (keyboard, mouse, controllers), `Geometry`, `Easing`, `Layout`, `Numeric`
  extensions, `Kernel.tick_count`, and the `tick`/`boot`/`reset` hooks.
- **Added here** (`stubs/extensions`), checked against the DragonRuby 7.22 docs, sample apps and open-source runtime:
  - `args.state` (entities, `new_entity`, `new_entity_strict`), `args.grid`, `args.events`, `args.pixel_array(s)`
  - The `DR` and `Grid` constants, plus the `$grid` and `$state` globals
  - `Grid` orientation/origin, all-screen and pixel-category properties
  - More `DR` functions: save data, env vars, window size/position, `on_tick_count`, `benchmark`, `reset_and_replay`, ...
  - Keyboard key states (`key_down.space`, `key_held.truthy_keys`, `key_down?(:enter)`), WASD/arrow helpers
  - Controller dpad and directional vectors, `accept`/`cancel`, and face button aliases (`south`, `east`, ...)
  - `args.inputs.mouse.buttons.left.buffered_click` and the other mouse button properties
  - `vec2_*` and other `Geometry` functions, and the Geometry mixin on `Hash`/`Array` (`rect.intersect_rect?(other)`)
  - `Numeric#frame_index`, `elapsed_time`, `to_sf`, ..., plus `Array#map_2d`, `include_any?`, and `Layout.row_count`, ...
  - `outputs.watch`/`outputs.debug.watch`, `outputs.sounds`, `did_reset`/`shutdown`, `attr_dr`, `Kernel.global_tick_count`
- **Indie and Pro APIs** are included. Their hover docs say which license tier they need:
  - Shaders: `outputs.shader = { path:, uniforms:, textures: }` (Indie/Pro)
  - C Extensions: `DR.dlopen`, `DR.get_dlopen_path` (Indie/Pro)
  - HD and All Screen: `DR.set_hd_max_scale`, `set_hd_letterbox`, `toggle_hd_letterbox`, `Layout.allscreen_rect`,
    and `Grid`'s all-screen, pixel-category and scale properties (Pro)
  - `DR.start_text_input`/`stop_text_input`, `args.inputs.http_requests` (Pro)

  Completions don't depend on your license, so check the hover note before relying on one of these.

## Editor setup

### VS Code

Install the [Solargraph extension](https://marketplace.visualstudio.com/items?itemName=castwide.solargraph).

### Vim/Neovim

Install the Solargraph LSP with [Mason](https://github.com/williamboman/mason.nvim), or point
your LSP client at `solargraph stdio`.

### Sublime Text

Install the [LSP](https://lsp.sublimetext.io/) package, then add Solargraph under
`Settings > Package Settings > LSP > Settings`:

```json
{
  "clients": {
    "solargraph": {
      "enabled": true,
      "command": ["solargraph", "stdio"],
      "selector": "source.ruby",
      "initializationOptions": { "diagnostics": true }
    }
  }
}
```

## Development

```sh
bin/setup              # install dependencies
bundle exec rake       # tests + standardrb
bundle exec rake stubs:sync        # re-vendor upstream stubs from main
bundle exec rake stubs:sync[<ref>] # ...or from a specific branch/tag
```

- `stubs/upstream/` is vendored verbatim; `UPSTREAM` records the source commit. Don't edit it by hand.
- `stubs/extensions/` holds our additions. When an extension re-declares an upstream
  method (for example to add a return type), the upstream definition is dropped.
- The Solargraph dependency is pinned to `~> 0.61.0`, because its plugin internals
  change between minor releases. Re-run the tests before widening it.

## Credits and license

The gem is available under the [MIT License](LICENSE.txt). The vendored stubs in
`stubs/upstream` are by Owen Butler and contributors, also MIT licensed (see
[stubs/upstream/LICENSE.txt](stubs/upstream/LICENSE.txt)).
