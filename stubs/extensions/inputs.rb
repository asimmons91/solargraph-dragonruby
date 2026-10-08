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
      :w, :x, :y, :z,
      :caps_lock, :home, :end, :page_up, :page_down, :insert, :print_screen, :scroll_lock, :pause,
      :f1, :f2, :f3, :f4, :f5, :f6, :f7, :f8, :f9, :f10, :f11, :f12,
      :at, :hash, :caret, :ampersand, :asterisk, :plus, :forward_slash, :back_slash,
      :less_than, :greater_than, :question_mark, :section, :ordinal_indicator, :superscript_two,
      :num_lock, :kp_zero, :kp_one, :kp_two, :kp_three, :kp_four, :kp_five, :kp_six, :kp_seven,
      :kp_eight, :kp_nine, :kp_period, :kp_plus, :kp_minus, :kp_multiply, :kp_divide, :kp_enter, :kp_equals

    # @return [Integer, nil] numeric SDL identifier of the last key in this state
    attr_reader :raw_key

    # @return [Integer, nil] ascii value of the last key in this state (follows OS key repeat for `key_down`)
    attr_reader :char

    # @return [Hash{Integer => Integer}] raw SDL keycode states, for keys without a named property
    attr_reader :keycodes

    # @return [Array<Symbol>] all keys in this state (relatively expensive; avoid calling every frame)
    def truthy_keys; end

    # True if any of `keys` is in this state. A key ending in `!`
    # (e.g. `:enter!`) is cleared when this returns true, so later checks
    # on the same frame don't see it.
    #
    # @param keys [Array<Symbol>]
    # @return [Boolean]
    def any? keys; end

    # True if all of `keys` are in this state. Keys ending in `!` are
    # cleared when this returns true (see #any?).
    #
    # @param keys [Array<Symbol>]
    # @return [Boolean]
    def all? keys; end

    # @return [Typing::PointHash, nil] normalized `x`, `y` from WASD and arrow keys; `nil` if none are in this state
    def directional_vector; end

    # @return [Typing::PointHash, nil] normalized `x`, `y` from WASD keys only
    def directional_vector_wasd; end

    # @return [Typing::PointHash, nil] normalized `x`, `y` from arrow keys only
    def directional_vector_arrow; end

    # @return [Float, nil] angle in degrees of #directional_vector
    def directional_angle; end

    # @return [Integer] `-1` (left), `0`, or `+1` (right)
    def left_right; end

    # @return [Integer] `-1` (down), `0`, or `+1` (up)
    def up_down; end
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

    # Keys pressed or held, e.g. `args.inputs.keyboard.space`. `hash` is only
    # available on the key states (`keyboard.key_down.hash`), since
    # `keyboard.hash` is Object#hash.
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
      :s, :t, :u, :v, :w, :x, :y, :z,
      :caps_lock, :home, :end, :page_up, :page_down, :insert, :print_screen, :scroll_lock, :pause,
      :f1, :f2, :f3, :f4, :f5, :f6, :f7, :f8, :f9, :f10, :f11, :f12,
      :at, :caret, :ampersand, :asterisk, :plus, :forward_slash, :back_slash,
      :less_than, :greater_than, :question_mark, :section, :ordinal_indicator, :superscript_two,
      :num_lock, :kp_zero, :kp_one, :kp_two, :kp_three, :kp_four, :kp_five, :kp_six, :kp_seven,
      :kp_eight, :kp_nine, :kp_period, :kp_plus, :kp_minus, :kp_multiply, :kp_divide, :kp_enter, :kp_equals

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

    # @return [Typing::PointHash, nil] normalized `x`, `y` from WASD keys only; `nil` if none are down or held
    def directional_vector_wasd; end

    # @return [Typing::PointHash, nil] normalized `x`, `y` from arrow keys only; `nil` if none are down or held
    def directional_vector_arrow; end

    # @return [Typing::PointHash, nil] normalized `x`, `y` from WASD and arrow keys; `nil` if none are down or held
    def directional_vector; end

    # @return [Float, nil] angle in degrees of #directional_vector; `nil` if no direction is down or held
    def directional_angle; end

    # @return [Typing::KeyStatesHash] keys in each state (`down`, `held`, `down_or_held`, `up`, `repeat`)
    def keys; end
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

    # @return [Typing::PointHash, nil] normalized `x`, `y` from the directions in this state; `nil` if none
    def directional_vector; end

    # @return [Float, nil] angle in degrees of #directional_vector
    def directional_angle; end

    # @return [Integer] `-1` (left), `0`, or `+1` (right)
    def left_right; end

    # @return [Integer] `-1` (down), `0`, or `+1` (up)
    def up_down; end
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

    # @return [Typing::PointHash, nil] normalized `x`, `y` from the dpad only; `nil` if nothing is pressed
    def directional_vector_dpad; end

    # @return [Typing::PointHash] normalized `x`, `y` from the left analog stick
    def directional_vector_left_analog; end

    # @return [Typing::PointHash, nil] cardinal-snapped `x`, `y` from the left analog stick; `nil` at rest
    def directional_vector_left_analog_cardinal; end

    # @return [Typing::PointHash] normalized `x`, `y` from the right analog stick
    def directional_vector_right_analog; end

    # @return [Typing::PointHash, nil] cardinal-snapped `x`, `y` from the right analog stick; `nil` at rest
    def directional_vector_right_analog_cardinal; end

    # @return [Typing::PointHash] normalized `x`, `y` from the dpad and left analog stick
    def directional_vector_left; end

    # @return [Typing::PointHash] normalized `x`, `y` from the right analog stick, falling back to the face buttons
    def directional_vector_right; end

    # @return [Typing::PointHash] normalized `x`, `y` using the face buttons as directions (twin-stick style)
    def directional_vector_buttons; end

    # @return [Typing::PointHash, nil] normalized `x`, `y` from the dpad and left analog stick; `nil` at rest
    def directional_vector; end

    # @return [Float, nil] angle in degrees of #directional_vector; `nil` at rest
    def directional_angle; end

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

    # @return [GTK::MousePoint, nil] where and when the button was clicked/down, or `nil`
    attr_reader :click

    # @return [Integer, nil] `Kernel.tick_count` of the click
    attr_reader :click_at

    # @return [Integer, nil] `Kernel.global_tick_count` of the click
    attr_reader :global_click_at

    # @return [GTK::MousePoint, nil] where and when the button was released, or `nil`
    attr_reader :up

    # @return [Integer, nil] `Kernel.tick_count` of the release
    attr_reader :up_at

    # @return [Integer, nil] `Kernel.global_tick_count` of the release
    attr_reader :global_up_at

    # @return [GTK::MousePoint, nil] current position and when the hold started, or `nil`
    attr_reader :held

    # @return [Integer, nil] `Kernel.tick_count` the hold started
    attr_reader :held_at

    # @return [Integer, nil] `Kernel.global_tick_count` the hold started
    attr_reader :global_held_at

    # @return [GTK::MousePoint, nil] same as #click
    attr_reader :down

    # @return [Integer, nil] same as #click_at
    attr_reader :down_at

    # @return [Integer, nil] same as #global_click_at
    attr_reader :global_down_at

    # @return [GTK::MousePoint, nil] the previous click of this button
    attr_reader :previous_click

    # @return [Numeric] mouse position
    attr_reader :x, :y

    # @return [Integer] ticks the button has been held (`0` if it isn't)
    def held_duration; end

    # The click, if the button was exclusively determined to be a click
    # (released quickly without moving far) and won't be considered held.
    #
    # @return [GTK::MousePoint, nil] where and when the click happened, or `nil`
    def buffered_click; end

    # The hold, if the button was exclusively determined to be held (pressed
    # long enough or dragged) and won't be considered a click.
    #
    # @return [GTK::MousePoint, nil] current position and when the hold started, or `nil`
    def buffered_held; end
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

    # MouseButton#buffered_click of the first button that has one.
    #
    # @return [GTK::MousePoint, nil]
    def buffered_click; end

    # MouseButton#buffered_held of the first button that has one.
    #
    # @return [GTK::MousePoint, nil]
    def buffered_held; end

    # Buttons pressed on this frame, e.g. `args.inputs.mouse.key_down.left`.
    #
    # @return [GTK::MouseKeys]
    attr_reader :key_down

    # Buttons held (all frames after `key_down` until released).
    #
    # @return [GTK::MouseKeys]
    attr_reader :key_held

    # Buttons released on this frame.
    #
    # @return [GTK::MouseKeys]
    attr_reader :key_up

    # The mouse as a zero-size rect. `offset` (`{ x:, y: }`) is added to the
    # position, e.g. to get the mouse relative to a render target's origin.
    #
    # @param offset [Typing::Point, Object, nil]
    # @return [Typing::RectHash] `{ x:, y:, w: 0, h: 0 }`
    def rect offset: nil; end

    # @param center_point [Typing::Point, Object] responds to `x`, `y`
    # @param radius [Float]
    # @return [Boolean] true if the mouse is inside the circle
    def inside_circle? center_point, radius; end

    # @return [Typing::PointHash, nil] wheel movement on each axis this frame, or `nil`
    attr_reader :wheel

    # The mouse position. `offset` (`{ x:, y: }`) is added to it.
    #
    # @param offset [Typing::Point, Object, nil]
    # @return [Typing::RectHash] `{ x:, y:, w: 0, h: 0 }`
    def point offset: nil; end

    # Same as #point.
    #
    # @param offset [Typing::Point, Object, nil]
    # @return [Typing::RectHash] `{ x:, y:, w: 0, h: 0 }`
    def position offset: nil; end

    # @param rect [Typing::Rect, Object] responds to `x`, `y`, `w`, `h`
    # @param offset [Typing::Point, Object, nil] added to the mouse position first
    # @return [Boolean] true if the mouse is inside `rect`
    def inside_rect? rect, offset: nil; end

    # @param other_rect [Typing::Rect, Object] responds to `x`, `y`, `w`, `h`
    # @param offset [Typing::Point, Object, nil] ignored by the runtime
    # @return [Boolean] true if the mouse intersects `other_rect`
    def intersect_rect? other_rect, offset: nil; end

    # @return [Typing::RectHash] #point offset by `Grid.allscreen_offset`
    def point_allscreen_offset; end

    # @return [Typing::RectHash] #rect offset by `Grid.allscreen_offset`
    def rect_allscreen_offset; end

    # @return [Integer] always `0`
    def w; end

    # @return [Integer] always `0`
    def h; end

    # @return [GTK::MousePoint, nil] the left button's click or hold, if either
    def left; end

    # @return [GTK::MousePoint, nil] the middle button's click or hold, if either
    def middle; end

    # @return [GTK::MousePoint, nil] the right button's click or hold, if either
    def right; end

    # @return [GTK::MousePoint, nil] the x1 button's click or hold, if either
    def x1; end

    # @return [GTK::MousePoint, nil] the x2 button's click or hold, if either
    def x2; end

    # @return [Boolean] true if the x1 (back) button is down
    attr_reader :button_x1

    # @return [Boolean] true if the x2 (forward) button is down
    attr_reader :button_x2

    # @return [GTK::MousePoint, nil] the left button's hold
    def held; end

    # @return [Integer, nil] `Kernel.tick_count` the left button was clicked
    def click_at; end

    # @return [Integer, nil] `Kernel.global_tick_count` the left button was clicked
    def global_click_at; end

    # @return [Integer, nil] `Kernel.tick_count` the left button's hold started
    def held_at; end

    # @return [Integer, nil] `Kernel.global_tick_count` the left button's hold started
    def global_held_at; end

    # @return [Integer, nil] `Kernel.tick_count` the left button was released
    def up_at; end

    # @return [Integer, nil] `Kernel.global_tick_count` the left button was released
    def global_up_at; end

    # @return [Integer, nil] `Kernel.tick_count` the mouse last moved
    attr_reader :moved_at

    # @return [Integer, nil] `Kernel.global_tick_count` the mouse last moved
    attr_reader :global_moved_at

    # @return [Integer, nil] `Kernel.tick_count` if the mouse was used on this frame
    attr_reader :active

    # @param key [Symbol] `:left`, `:middle`, `:right`, `:x1`, or `:x2`
    # @return [GTK::MousePoint, nil]
    def key_down? key; end

    # @param key [Symbol]
    # @return [GTK::MousePoint, nil]
    def key_up? key; end

    # @param key [Symbol]
    # @return [GTK::MousePoint, nil]
    def key_held? key; end

    # @param key [Symbol]
    # @return [GTK::MousePoint, nil]
    def key_down_or_held? key; end
  end

  # Mouse button states for one event type, via
  # `args.inputs.mouse.(key_down|key_held|key_up)`.
  class MouseKeys
    # @return [GTK::MousePoint, nil] where and when the button entered this state, or `nil`
    attr_reader :left, :middle, :right, :x1, :x2
  end

  # One touch point, from the values of `args.inputs.touch` (touch devices only).
  class FingerTouch
    # @return [Numeric]
    attr_reader :x, :y

    # @return [Numeric] position on the previous frame
    attr_reader :previous_x, :previous_y

    # @return [Boolean] true if the finger moved on this frame
    attr_reader :moved

    # @return [Integer] `Kernel.tick_count` the finger last moved
    attr_reader :moved_at

    # @return [Integer] `Kernel.global_tick_count` the finger last moved
    attr_reader :global_moved_at

    # @return [Integer] `Kernel.tick_count` the finger touched down
    attr_reader :down_at

    # @return [Integer] `Kernel.global_tick_count` the finger touched down
    attr_reader :global_down_at

    # @return [Integer] `0` for the first finger down, `1` for the second, ...
    attr_reader :touch_order

    # @return [Typing::PointHash] `{ x:, y: }`
    def point; end

    # @return [Typing::PointHash] `{ x:, y: }` (same as #point)
    def position; end

    # @param rect [Typing::Rect, Object] responds to `x`, `y`, `w`, `h`
    # @return [Boolean]
    def inside_rect? rect; end

    # @param center [Typing::Point, Object] responds to `x`, `y`
    # @param radius [Numeric]
    # @return [Boolean]
    def inside_circle? center, radius; end
  end

  # Directional state shared by the keyboard (arrows and WASD) and
  # `controller_one` for one event type, via
  # `args.inputs.(key_down|key_held|key_up)`, e.g. `args.inputs.key_down.left`.
  class KeyboardOrControllerKeys
    # @return [Integer, Boolean, nil] truthy if the direction entered this state
    attr_reader :up, :down, :left, :right

    # @return [Typing::PointHash, nil] normalized `x`, `y` from the directions in this state; `nil` if none
    def directional_vector; end

    # @return [Float, nil] angle in degrees of #directional_vector
    def directional_angle; end

    # @return [Integer] `-1` (left), `0`, or `+1` (right)
    def left_right; end

    # @return [Integer] `-1` (down), `0`, or `+1` (up)
    def up_down; end
  end

  class MousePoint
    # @return [Typing::RectHash] `x`, `y` of the click, with `w`, `h` always `0`
    attr_reader :point

    # @param rect [Typing::Rect, Object] responds to `x`, `y`, `w`, `h`
    # @return [Boolean] true if the click is inside `rect`
    def inside_rect? rect; end

    # @param center_point [Typing::Point, Object] responds to `x`, `y`
    # @param radius [Float]
    # @return [Boolean] true if the click is inside the circle
    def inside_circle? center_point, radius; end

    # @return [Numeric]
    attr_accessor :x, :y
  end

  class Inputs
    # Text typed since the last frame, including IME/international input.
    # Only populated after `DR.start_text_input` (on touch devices that also
    # shows the on-screen keyboard; `DR.stop_text_input` dismisses it). For
    # simple key handling prefer `args.inputs.keyboard.key_down.char`.
    #
    # @return [Array<String>]
    def text; end

    # Pending requests to the in-game web server started with
    # `DR.start_server!`. Respond to each with `request.respond 200, "ok"`.
    #
    # Pro license.
    #
    # @return [Array<GTK::Runtime::HTTPRequest>]
    attr_reader :http_requests

    # All current touch points keyed by touch id (touch devices only).
    #
    # @return [Hash{Integer => GTK::FingerTouch}]
    attr_reader :touch

    # A touch point on the left half of the screen, as a 1x1 rect.
    #
    # @return [Typing::RectHash, nil]
    attr_reader :finger_left

    # A touch point on the right half of the screen, as a 1x1 rect.
    #
    # @return [Typing::RectHash, nil]
    attr_reader :finger_right

    # Directions pressed on this frame on the keyboard or `controller_one`,
    # e.g. `args.inputs.key_down.left`.
    #
    # @return [GTK::KeyboardOrControllerKeys]
    def key_down; end

    # Directions held on the keyboard or `controller_one`.
    #
    # @return [GTK::KeyboardOrControllerKeys]
    def key_held; end

    # Directions released on this frame on the keyboard or `controller_one`.
    #
    # @return [GTK::KeyboardOrControllerKeys]
    def key_up; end

    # Same as #left_right.
    # @return [Integer] `-1` (left), `0`, or `+1` (right)
    def left_right_with_wasd; end

    # Same as #left_right_perc.
    # @return [Float] `-1.0` to `1.0`
    def left_right_perc_with_wasd; end

    # @return [Integer] `-1` (left), `0`, or `+1` (right) from the arrow keys and dpad only (no WASD or analog)
    def left_right_arrow; end

    # Same as #left_right_arrow.
    # @return [Integer] `-1` (left), `0`, or `+1` (right)
    def left_right_dpad; end

    # Same as #left_right_directional_perc: the left analog stick, falling
    # back to the dpad and arrow keys (no WASD).
    # @return [Float] `-1.0` to `1.0`
    def left_right_perc_dpad; end

    # Same as #up_down.
    # @return [Integer] `-1` (down), `0`, or `+1` (up)
    def up_down_with_wasd; end

    # @return [Integer] `-1` (down), `0`, or `+1` (up) from the arrow keys and dpad only (no WASD or analog)
    def up_down_arrow; end

    # @return [Typing::PointHash, nil] normalized `x`, `y` from the keyboard, falling back to `controller_one`; `nil` at rest
    def directional_vector; end

    # @return [Float, nil] angle in degrees of #directional_vector; `nil` at rest
    def directional_angle; end

    # @return [GTK::FingerTouch, nil] the first finger touching the screen
    attr_reader :finger_one

    # @return [GTK::FingerTouch, nil] the second finger touching the screen
    attr_reader :finger_two

    # Change in distance between two fingers on this frame (positive when
    # pinching in). The mouse wheel also sets it. `0` when not pinching.
    #
    # @return [Numeric]
    attr_reader :pinch_zoom

    # @return [Boolean] true if the device supports touch
    def touch_enabled?; end
  end
end
