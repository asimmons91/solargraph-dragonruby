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
