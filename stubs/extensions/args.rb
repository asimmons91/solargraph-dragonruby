module GTK
  class Args
    # Property bag for your game's state. Values are retained across `tick`
    # invocations and cleared by `DR.reset`. Arbitrarily nested properties
    # are allowed, and a backing entity is created on your behalf.
    #
    # Recommended initialization (in `boot`): `args.state = {}`
    #
    # @return [GTK::OpenEntity]
    attr_accessor :state

    # Screen and canvas information. Also available globally as `Grid`
    # (preferred) and `$grid`.
    #
    # @return [GTK::Grid]
    attr_reader :grid

    # Raw and window resize events.
    #
    # @return [GTK::Events]
    attr_reader :events

    # All pixel arrays created via #pixel_array, keyed by name.
    #
    # @return [Hash{Symbol => GTK::PixelArray}]
    attr_reader :pixel_arrays

    # Returns the pixel array named `name`, creating it if needed. Render it
    # with `args.outputs.sprites << { ..., path: name }`.
    #
    # @param name [Symbol]
    # @return [GTK::PixelArray]
    def pixel_array name; end

    # The runtime. Prefer the `DR` constant.
    #
    # @return [GTK::Runtime]
    attr_reader :gtk

    # Current tick of the game. Prefer `Kernel.tick_count`.
    #
    # @return [Integer]
    attr_reader :tick_count

    # Audio sources that are playing, keyed by name. Assign a Hash to play
    # one (`args.audio[:music] = { input: "sounds/music.ogg", looping: true }`);
    # a `:length` key (seconds) is added on the following tick.
    #
    # @return [AudioHash]
    attr_reader :audio
  end

  class Events
    # @return [Boolean] true if the window was resized or the orientation of the game changed.
    attr_reader :resize_occurred

    # @return [Boolean] true if the orientation of the game changed (only possible when
    #   `orientation` in `game_metadata.txt` is `landscape,portrait` or `portrait,landscape`).
    attr_reader :orientation_changed

    # Raw events. These are already reflected in the rest of the API, so this is
    # mostly useful for debugging.
    #
    # @return [Array<Hash>]
    attr_reader :raw
  end

  class PixelArray
    # @return [Integer]
    attr_accessor :w, :h

    # Hexadecimal color values in ABGR format, starting at the top-left
    # pixel. `nil` entries render as a checkerboard.
    #
    # @return [Array<Integer>]
    attr_accessor :pixels
  end
end

# The type of `args.audio`: a Hash of audio sources plus a global volume.
class AudioHash < Hash
  # Global volume for all audio, from `0.0` to `1.0` (defaults to `1.0`, or
  # `0.4` on iOS). Web builds in production return `0.0` while the game
  # doesn't have focus.
  #
  # @return [Float]
  attr_reader :volume

  # @param value [Float] clamped to `0.0..1.0`
  attr_writer :volume
end
