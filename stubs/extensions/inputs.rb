module GTK
  # State of the keyboard keys for one event type (`key_down`, `key_held`,
  # `key_up`, `key_repeat`), e.g. `args.inputs.keyboard.key_down.space`.
  # Each key returns the tick it entered that state, or a falsey value.
  class KeyboardKeys
    # @return [Integer, false, nil]
    attr_reader :alt, :option, :alt_left, :option_left, :alt_right, :option_right, :meta, :command,
      :meta_left, :command_left, :meta_right, :command_right, :control, :ctrl, :control_left, :ctrl_left,
      :control_right, :ctrl_right, :shift, :shift_left, :shift_right, :backspace, :delete, :escape,
      :enter, :tab, :space, :exclamation_point, :open_round_brace, :close_round_brace, :open_curly_brace, :close_curly_brace,
      :open_square_brace, :close_square_brace, :colon, :semicolon, :equal, :hyphen, :dollar, :percent,
      :double_quotation_mark, :single_quotation_mark, :backtick, :tilde, :period, :comma, :pipe, :underscore,
      :left_arrow, :right_arrow, :up_arrow, :down_arrow, :left, :right, :up, :down,
      :pageup, :pagedown, :w_scancode, :a_scancode, :s_scancode, :d_scancode, :up_wasd, :down_wasd,
      :left_wasd, :right_wasd, :ac_back, :ac_home, :ac_forward, :ac_stop, :ac_refresh, :ac_bookmarks,
      :zero, :one, :two, :three, :four, :five, :six, :seven,
      :eight, :nine, :a, :b, :c, :d, :e, :f,
      :g, :h, :i, :j, :k, :l, :m, :n,
      :o, :p, :q, :r, :s, :t, :u, :v,
      :w, :x, :y, :z

    # @return [Integer, nil] ascii value of the last key in this state (follows OS key repeat for `key_down`)
    attr_reader :char

    # @return [Hash{Integer => Integer}] raw SDL keycode states, for keys without a named property
    attr_reader :keycodes

    # @return [Array<Symbol>] all keys in this state (relatively expensive; avoid calling every frame)
    def truthy_keys; end
  end

  class Keyboard
    # @return [GTK::KeyboardKeys] keys pressed on this frame
    attr_reader :key_down

    # @return [GTK::KeyboardKeys] keys held (all frames after `key_down` until released)
    attr_reader :key_held

    # @return [GTK::KeyboardKeys] keys released on this frame
    attr_reader :key_up

    # @return [GTK::KeyboardKeys] keys pressed or repeated, based on OS key repeat speed
    attr_reader :key_repeat

    # Keys pressed or held, e.g. `args.inputs.keyboard.space`.
    # @return [Integer, false, nil]
    attr_reader :alt, :option, :alt_left, :option_left, :alt_right, :option_right, :meta, :command,
      :meta_left, :command_left, :meta_right, :command_right, :control, :ctrl, :control_left, :ctrl_left,
      :control_right, :ctrl_right, :shift, :shift_left, :shift_right, :backspace, :delete, :escape,
      :enter, :tab, :space, :exclamation_point, :open_round_brace, :close_round_brace, :open_curly_brace, :close_curly_brace,
      :open_square_brace, :close_square_brace, :colon, :semicolon, :equal, :hyphen, :dollar, :percent,
      :double_quotation_mark, :single_quotation_mark, :backtick, :tilde, :period, :comma, :pipe, :underscore,
      :left_arrow, :right_arrow, :up_arrow, :down_arrow, :pageup, :pagedown, :w_scancode, :a_scancode,
      :s_scancode, :d_scancode, :up_wasd, :down_wasd, :left_wasd, :right_wasd, :ac_back, :ac_home,
      :ac_forward, :ac_stop, :ac_refresh, :ac_bookmarks, :zero, :one, :two, :three,
      :four, :five, :six, :seven, :eight, :nine, :a, :b,
      :c, :d, :e, :f, :g, :h, :i, :j,
      :k, :l, :m, :n, :o, :p, :q, :r,
      :s, :t, :u, :v, :w, :x, :y, :z

    # @param key [Symbol]
    # @return [Boolean] true if `key` was pressed on this frame
    def key_down? key; end

    # @param key [Symbol]
    # @return [Boolean] true if `key` was released on this frame
    def key_up? key; end

    # @param key [Symbol]
    # @return [Boolean] true if `key` is held
    def key_held? key; end

    # @param key [Symbol]
    # @return [Boolean] true if `key` was pressed on this frame or is held
    def key_down_or_held? key; end

    # @param key [Symbol]
    # @return [Boolean] true if `key` was pressed or repeated on this frame
    def key_repeat? key; end

    # @return [Integer] `-1` (left), `0`, or `+1` (right) from WASD keys only
    def left_right_wasd; end

    # @return [Integer] `-1` (left), `0`, or `+1` (right) from arrow keys only
    def left_right_arrow; end

    # @return [Integer] `-1` (down), `0`, or `+1` (up) from WASD keys only
    def up_down_wasd; end

    # @return [Integer] `-1` (down), `0`, or `+1` (up) from arrow keys only
    def up_down_arrow; end

    # @return [Hash, nil] normalized `x`, `y` from WASD keys only; `nil` if none are down or held
    def directional_vector_wasd; end

    # @return [Hash, nil] normalized `x`, `y` from arrow keys only; `nil` if none are down or held
    def directional_vector_arrow; end
  end

  # Button states for one event type (`key_down`, `key_held`, `key_up`),
  # e.g. `args.inputs.controller_one.key_down.a`.
  class ControllerKeys
    # @return [Integer, false, nil] tick the button entered this state, or a falsey value
    attr_reader :a, :b, :x, :y, :l1, :r1, :l2, :r2, :l3, :r3, :start, :select,
                :up, :down, :left, :right,
                :directional_up, :directional_down, :directional_left, :directional_right,
                :n, :north, :s, :south, :e, :east, :w, :west,
                :cross, :circle, :square, :triangle

    # @return [Array<Symbol>] all buttons in this state
    def truthy_keys; end
  end

  class Controller
    # @return [GTK::ControllerKeys] buttons pressed on this frame
    attr_reader :key_down

    # @return [GTK::ControllerKeys] buttons held (all frames after `key_down` until released)
    attr_reader :key_held

    # @return [GTK::ControllerKeys] buttons released on this frame
    attr_reader :key_up

    # Face button aliases. Cardinal names (`n`/`north`, ...) are recommended
    # over `a`/`b`/`x`/`y`, whose positions vary between controllers.
    #
    # @return [Boolean]
    attr_reader :n, :north, :s, :south, :e, :east, :w, :west,
                :cross, :circle, :square, :triangle

    # @return [Boolean] the south face button (east on a Nintendo Switch Pro Controller); use for confirm
    def accept; end

    # @return [Boolean] the east face button (south on a Nintendo Switch Pro Controller); use for back
    def cancel; end

    # @return [Boolean] true if up is pressed or held on the dpad only (analog is not consulted)
    def up_dpad; end

    # @return [Boolean] true if down is pressed or held on the dpad only
    def down_dpad; end

    # @return [Boolean] true if left is pressed or held on the dpad only
    def left_dpad; end

    # @return [Boolean] true if right is pressed or held on the dpad only
    def right_dpad; end

    # @return [Hash, nil] normalized `x`, `y` from the dpad only; `nil` if nothing is pressed
    def directional_vector_dpad; end

    # @return [Hash] normalized `x`, `y` from the left analog stick
    def directional_vector_left_analog; end

    # @return [Hash, nil] cardinal-snapped `x`, `y` from the left analog stick; `nil` at rest
    def directional_vector_left_analog_cardinal; end

    # @return [Hash] normalized `x`, `y` from the right analog stick
    def directional_vector_right_analog; end

    # @return [Hash, nil] cardinal-snapped `x`, `y` from the right analog stick; `nil` at rest
    def directional_vector_right_analog_cardinal; end

    # @return [Hash] normalized `x`, `y` from the dpad and left analog stick
    def directional_vector_left; end

    # @return [Hash] normalized `x`, `y` from the right analog stick, falling back to the face buttons
    def directional_vector_right; end

    # @return [Hash] normalized `x`, `y` using the face buttons as directions (twin-stick style)
    def directional_vector_buttons; end

    # @return [Float] angle of the left analog stick in degrees
    def left_analog_angle; end

    # @return [Float] angle of the right analog stick in degrees
    def right_analog_angle; end

    # Raw analog value below which the stick is considered at rest (default `3600`).
    # @return [Integer]
    attr_accessor :analog_dead_zone

    # @param key [Symbol]
    # @return [Boolean]
    def key_down? key; end

    # @param key [Symbol]
    # @return [Boolean]
    def key_up? key; end

    # @param key [Symbol]
    # @return [Boolean]
    def key_held? key; end

    # @param key [Symbol]
    # @return [Boolean]
    def key_down_or_held? key; end
  end

  # One mouse button, via `args.inputs.mouse.buttons.(left|middle|right|x1|x2)`.
  class MouseButton
    # @return [Symbol] `:left`, `:middle`, `:right`, `:x1`, or `:x2`
    attr_reader :id

    # @return [Integer] `0` to `4`
    attr_reader :index

    # @return [Object, nil] truthy if the button was clicked/down
    attr_reader :click

    # @return [Integer, nil] `Kernel.tick_count` of the click
    attr_reader :click_at

    # @return [Integer, nil] `Kernel.global_tick_count` of the click
    attr_reader :global_click_at

    # @return [Object, nil] truthy if the button was released
    attr_reader :up

    # @return [Integer, nil] `Kernel.tick_count` of the release
    attr_reader :up_at

    # @return [Integer, nil] `Kernel.global_tick_count` of the release
    attr_reader :global_up_at

    # @return [Object, nil] truthy if the button is held
    attr_reader :held

    # @return [Integer, nil] `Kernel.tick_count` the hold started
    attr_reader :held_at

    # @return [Integer, nil] `Kernel.global_tick_count` the hold started
    attr_reader :global_held_at

    # @return [Boolean] true if exclusively determined to be a click (not a hold)
    attr_reader :buffered_click

    # @return [Boolean] true if exclusively determined to be a hold (not a click)
    attr_reader :buffered_held
  end

  class MouseButtons
    # @return [GTK::MouseButton]
    attr_reader :left, :middle, :right, :x1, :x2
  end

  class Mouse
    # Per-button state, for telling a held drag apart from a click.
    #
    # @return [GTK::MouseButtons]
    attr_reader :buttons
  end
end
