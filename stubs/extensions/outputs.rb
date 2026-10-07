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
    # @return [Hash, nil]
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
  end
end
