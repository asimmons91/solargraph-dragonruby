module GTK
  module Easing
    class << self
      # Progress along a series of 4-point bezier curves, each given an equal
      # share of `duration`.
      #
      # @example linear out and back
      #   Easing.spline 10, Kernel.tick_count, 300, [[0, 0.25, 0.75, 1.0], [1.0, 0.75, 0.25, 0]]
      #
      # @param start_tick [Integer]
      # @param current_tick [Integer]
      # @param duration [Integer] duration in ticks
      # @param spline [Array<Array<Numeric>>] bezier definitions, four values each
      # @return [Float] the value on the curve; the last point of the spline once `duration` has passed
      def spline start_tick, current_tick, duration, spline; end

      # Accelerating ease (`perc ** power`). Pass either
      # `initial:`, `final:`, `perc:` or `start_at:` with `end_at:` or `duration:`.
      #
      # @example percentage-based
      #   Easing.smooth_start initial: 0, final: 1280, perc: 0.5, power: 2
      # @example time-based
      #   Easing.smooth_start start_at: 60, duration: 120, power: 3
      #
      # @param initial [Float, nil] starting value
      # @param final [Float, nil] ending value
      # @param perc [Float, nil] current percentage (over `1.0` overshoots `final`)
      # @param start_at [Integer, nil] tick the easing starts
      # @param end_at [Integer, nil] tick the easing ends
      # @param duration [Integer, nil] ticks from `start_at` to the end
      # @param tick_count [Integer, nil] current tick (defaults to `Kernel.tick_count`)
      # @param power [Numeric] `1` linear, `2` quadratic, `3` cubic, ...
      # @param flip [Boolean] return `1 - result` (go from 1 to 0)
      # @return [Float]
      def smooth_start initial: nil, final: nil, perc: nil, start_at: nil, end_at: nil, duration: nil, tick_count: nil, power: 1, flip: false; end

      # Decelerating ease (`1 - (1 - perc) ** power`). Takes the same
      # arguments as #smooth_start.
      #
      # @param initial [Float, nil] starting value
      # @param final [Float, nil] ending value
      # @param perc [Float, nil] current percentage (over `1.0` overshoots `final`)
      # @param start_at [Integer, nil] tick the easing starts
      # @param end_at [Integer, nil] tick the easing ends
      # @param duration [Integer, nil] ticks from `start_at` to the end
      # @param tick_count [Integer, nil] current tick (defaults to `Kernel.tick_count`)
      # @param power [Numeric] `1` linear, `2` quadratic, `3` cubic, ...
      # @param flip [Boolean] return `1 - result` (go from 1 to 0)
      # @return [Float]
      def smooth_stop initial: nil, final: nil, perc: nil, start_at: nil, end_at: nil, duration: nil, tick_count: nil, power: 1, flip: false; end

      # 50/50 mix of #smooth_start and #smooth_stop. Takes the same arguments
      # as #smooth_start.
      #
      # @param initial [Float, nil] starting value
      # @param final [Float, nil] ending value
      # @param perc [Float, nil] current percentage (over `1.0` overshoots `final`)
      # @param start_at [Integer, nil] tick the easing starts
      # @param end_at [Integer, nil] tick the easing ends
      # @param duration [Integer, nil] ticks from `start_at` to the end
      # @param tick_count [Integer, nil] current tick (defaults to `Kernel.tick_count`)
      # @param power [Numeric] `1` linear, `2` quadratic, `3` cubic, ...
      # @param flip [Boolean] return `1 - result` (go from 1 to 0)
      # @return [Float]
      def smooth_step initial: nil, final: nil, perc: nil, start_at: nil, end_at: nil, duration: nil, tick_count: nil, power: 1, flip: false; end
    end
  end
end
