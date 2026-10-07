# @return [GTK::Runtime] recommended way to access the runtime: `DR.function(...)`
DR = GTK::Runtime.new

# @type [GTK::OpenEntity] same as `args.state`; meant for debugging in the console
$state = GTK::OpenEntity.new

# @!method did_reset(args)
#   called after DragonRuby's internal reset completes (see `reset`)
#   @param args [GTK::Args]
#   @return [void]

# @!method shutdown(args)
#   called before the game exits, and as part of `DR.reboot`
#   @param args [GTK::Args]
#   @return [void]

class ::Kernel
  class << self
    # current tick of the application since it started; never reset
    # @return [Integer]
    def global_tick_count; end
  end
end

module GTK
  class Runtime
    # Resizes the window. Development/debugging only; not guaranteed to work
    # cross platform.
    #
    # @param w [Integer]
    # @param h [Integer]
    # @return [void]
    def set_window_size w, h; end

    # Moves the window (origin is top left). Development/debugging only.
    #
    # @param x [Integer]
    # @param y [Integer]
    # @return [void]
    def set_window_position x, y; end

    # Brings the window to the front and focuses it (does nothing in
    # production). Development/debugging only.
    #
    # @return [void]
    def raise_window; end

    # Schedules a block to run at the beginning of the given frame.
    #
    # @example
    #   DR.on_tick_count Kernel.tick_count + 300 do |args|
    #     DR.notify "five seconds later"
    #   end
    #
    # @param tick_count [Integer]
    # @yieldparam args [GTK::Args]
    # @return [void]
    def on_tick_count tick_count, &block; end

    # Same as #calcstringbox, but returns a Hash.
    #
    # @param text [String]
    # @param size_enum [Integer]
    # @param font [String]
    # @return [Hash] with keys `w` and `h`
    def calcstringbox_h text, size_enum = nil, font = nil; end

    # Opens a uri in the user's default browser.
    #
    # @param uri [String]
    # @return [void]
    def openurl uri; end

    # @param name [String]
    # @return [String, nil] value of the environment variable, or `nil` if it doesn't exist
    def getenv name; end

    # @param name [String]
    # @param value [String]
    # @param overwrite [Boolean] whether to overwrite an existing value
    # @return [void]
    def setenv name, value, overwrite; end

    # Reads a file from the platform-specific save enclave (`__save_data__`
    # on most platforms). Use for user-specific data.
    #
    # @param file_path [String]
    # @return [String, nil] file contents, or `nil` if the file doesn't exist
    def read_save_data file_path; end

    # Writes (overwrites) a file in the platform-specific save enclave.
    #
    # @param file_path [String]
    # @param contents [String]
    # @return [void]
    def write_save_data file_path, contents; end

    # Resets the game and runs a recorded replay against the current code.
    # Put it at the bottom of `main.rb` to re-run the replay on every save.
    #
    # @param replay_file [String] e.g. `"replay.txt"`
    # @param speed [Integer] playback speed multiplier
    # @return [void]
    def reset_and_replay replay_file, speed: 1; end

    # Compares the performance of lambdas. Pass either `iterations:` (fastest
    # completion wins) or `seconds:` (most iterations wins), plus one lambda
    # per experiment as named arguments.
    #
    # @example
    #   DR.benchmark iterations: 1000,
    #                using_map: -> { 100.map { |i| i * 2 } },
    #                using_times: -> { a = []; 100.times { |i| a << i * 2 } }
    #
    # @param iterations [Integer, nil]
    # @param seconds [Numeric, nil]
    # @param experiments [Hash{Symbol => Proc}]
    # @return [Hash]
    def benchmark iterations: nil, seconds: nil, **experiments; end

    # Downloads a single-file library from GitHub, either by url or by
    # `user, repo, file`, and saves it under a predefined folder convention.
    #
    # @return [void]
    def download_lib *args; end

    # Downloads a file from a raw url and saves it to `local_path`.
    #
    # @param url [String]
    # @param local_path [String]
    # @return [void]
    def download_lib_raw url, local_path; end

    # Prints the caller next to every `puts`; useful for finding rogue
    # `puts` statements. Call at the top of `tick`.
    #
    # @return [void]
    def trace_puts!; end

    # iOS only.
    #
    # @return [Symbol, nil] `:unknown`, `:nominal`, `:fair`, `:serious`, or `:critical`; `nil` on other platforms
    def current_thermal_state; end

    # @!group Indie and Pro

    # Loads a precompiled C Extension by library name (no `lib` prefix or
    # platform-specific extension). See `samples/12_c_extensions`.
    #
    # Indie or Pro license to compile C Extensions or publish games that use
    # them. Standard can load them in dev mode only; calling this in
    # production raises.
    #
    # @param name [String]
    # @return [void]
    def dlopen name; end

    # Indie or Pro license.
    #
    # @param name [String, nil] library name, to get its full path
    # @return [String] the path searched for dynamic libraries by #dlopen
    def get_dlopen_path name = nil; end

    # Updates the `hd_max_scale` metadata value while the game is running,
    # for testing scaling on edge-to-edge displays. Development only.
    #
    # Pro license (no-op otherwise).
    #
    # @param scale [Integer] `100` (720p), `125` (HD+), `150` (1080p), `175` (Full HD+),
    #   `200` (1440p), `250` (1800p), `300` (4k), or `400` (5k)
    # @return [void]
    def set_hd_max_scale scale; end

    # Adds or removes the letterbox (`hd_letterbox` in `game_metadata.txt`)
    # while the game is running. Development only.
    #
    # Pro license (no-op otherwise).
    #
    # @return [void]
    def toggle_hd_letterbox; end

    # Adds (`true`) or removes (`false`) the letterbox (`hd_letterbox` in
    # `game_metadata.txt`) while the game is running. Development only.
    #
    # Pro license (no-op otherwise).
    #
    # @param letterbox [Boolean]
    # @return [void]
    def set_hd_letterbox letterbox; end

    # Starts text input so `args.inputs.text` is populated. On touch devices
    # this shows the on-screen keyboard.
    #
    # Pro license.
    #
    # @return [void]
    def start_text_input; end

    # Stops text input and dismisses the on-screen keyboard.
    #
    # Pro license.
    #
    # @return [void]
    def stop_text_input; end

    # @!endgroup

    # A request received by the in-game web server (`DR.start_server!`), from
    # `args.inputs.http_requests`. Requests not responded to are rejected
    # automatically after 30 seconds.
    #
    # Pro license.
    class HTTPRequest
      # @return [String]
      attr_reader :id

      # @return [String] client address
      attr_reader :address

      # @return [String] e.g. `"GET"`, `"POST"`
      attr_reader :method

      # @return [String] e.g. `"/"`
      attr_reader :uri

      # @return [Hash{String => String}]
      attr_reader :headers

      # @return [String, nil]
      attr_reader :raw_body

      # @return [Object] the request body
      attr_reader :body

      # @param httpcode [Integer] e.g. `200`
      # @param body [String, nil]
      # @param headers [Hash{String => String}, nil]
      # @return [void]
      def respond httpcode, body = nil, headers = nil; end

      # Responds with `400` and a plain-text rejection message.
      # @return [void]
      def reject; end
    end
  end
end
