module GTK
  class Outputs
    # Sounds to play once; push a file path (`args.outputs.sounds << "sounds/coin.wav"`).
    # Prefer `args.audio` for control over playback.
    #
    # @return [Array<String>]
    attr_reader :sounds

    # Shows a value on screen for debugging.
    #
    # @param obj [Object] converted to a string
    # @param label_style [Hash, nil] overrides the default label style
    # @param background_style [Hash, nil] overrides the default background style
    # @return [void]
    def watch obj, label_style: nil, background_style: nil; end

    # Watches every instance variable of `target` (dev builds only).
    #
    # @param target [Object]
    # @param label_style [Hash, nil]
    # @param background_style [Hash, nil]
    # @return [void]
    def watch_ivars target, label_style: nil, background_style: nil; end

    # Watches every attribute of `target` whose class has `attributes`
    # (dev builds only).
    #
    # @param target [Object]
    # @param label_style [Hash, nil]
    # @param background_style [Hash, nil]
    # @return [void]
    def watch_attrs target, label_style: nil, background_style: nil; end

    # Watches the current framerate (dev builds only).
    #
    # @return [void]
    def watch_fps; end

    # Render targets by name, to check whether one has been created yet.
    #
    # @example
    #   return if args.outputs.render_target_state.queued?(:minimap)
    #
    # @return [GTK::RenderTargetState]
    def render_target_state; end

    # Same as #render_target_state.
    #
    # @return [GTK::RenderTargetState]
    def rt_state; end

    # Accessibility nodes by id. Each value is a rect with `a11y_text:` and
    # `a11y_trait:` (e.g. `:button`), or `{ a11y_text:, a11y_trait: :notification }`.
    #
    # @example
    #   args.outputs.a11y[:play] = { a11y_text: "play", a11y_trait: :button, x: 100, y: 100, w: 200, h: 50 }
    #
    # @return [Hash]
    attr_reader :a11y

    # @return [Typing::ColorHash] #background_color as `{ r:, g:, b:, a: }`
    def background_color_h; end

    # Fragment shader applied to these outputs (the screen, or a render
    # target via `args.outputs[:name].shader = ...`). Shader files must be
    # `require`d before use, e.g. `require "shaders/effect.frag.hlsl"` at the
    # top of `main.rb`. See `samples/14_shaders`.
    #
    # Keys:
    # - `path:` [String] the required shader file
    # - `uniforms:` [Array<Hash>] values bound in order, each `{ type: :int | :float, value: }`
    # - `textures:` [Array<Symbol>] render targets bound as additional textures
    #
    # Indie or Pro license. Shaders are experimental and the API may change.
    #
    # @example
    #   args.outputs.shader = {
    #     path: "shaders/effect.frag.hlsl",
    #     uniforms: [{ type: :int, value: Kernel.tick_count }]
    #   }
    #
    # @return [Typing::ShaderHash, Hash, nil]
    attr_accessor :shader
  end

  class OutputsArray
    # Shows a value on screen for debugging (`args.outputs.debug.watch`).
    #
    # @param obj [Object] converted to a string
    # @param label_style [Hash, nil] overrides the default label style
    # @param background_style [Hash, nil] overrides the default background style
    # @return [void]
    def watch obj, label_style: nil, background_style: nil; end

    # Watches every instance variable of `target` (dev builds only).
    #
    # @param target [Object]
    # @param label_style [Hash, nil]
    # @param background_style [Hash, nil]
    # @return [void]
    def watch_ivars target, label_style: nil, background_style: nil; end

    # Watches every attribute of `target` whose class has `attributes`
    # (dev builds only).
    #
    # @param target [Object]
    # @param label_style [Hash, nil]
    # @param background_style [Hash, nil]
    # @return [void]
    def watch_attrs target, label_style: nil, background_style: nil; end

    # Watches the current framerate (dev builds only).
    #
    # @return [void]
    def watch_fps; end
  end

  # Render targets created via `args.outputs[name]`, by name.
  class RenderTargetState
    # @param name [Symbol, String]
    # @return [Typing::RenderTargetEntryHash, nil] the render target's entry (`path`, `ready`, ...)
    def [] name; end

    # @param name [Symbol, String]
    # @return [Boolean] true once a render target with this name has been requested
    def queued? name; end

    # @param name [Symbol, String]
    # @return [Boolean] true once the render target's texture is ready to use
    def ready? name; end
  end
end
