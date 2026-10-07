# The recommended entry point for a game (see docs/api/runtime.md, "Main").
# Functions defined in `Main` can call `args`, `inputs`, `outputs`, `state`,
# `events` and `audio` directly, and the hooks don't need to take `args`.
#
# Defining `Main#tick` disables OpenEntity and Array primitives, so `state`
# is a plain Hash (dot access like `state.score` still works).
module Main
  # Same object passed to top-level `tick args`.
  # @return [GTK::Args]
  attr_accessor :args

  # Same as `args.inputs`.
  # @return [GTK::Inputs]
  def inputs; end

  # Same as `args.outputs`.
  # @return [GTK::Outputs]
  def outputs; end

  # Same as `args.state`. A plain Hash in `Main` (OpenEntity is disabled),
  # retained across `tick` invocations and cleared by `DR.reset`.
  # @return [Hash]
  def state; end

  # Same as `args.events`.
  # @return [GTK::Events]
  def events; end

  # Same as `args.audio`.
  # @return [Hash]
  def audio; end

  # Called once, at the very beginning of the process, for setup.
  # @param args [GTK::Args]
  # @return [void]
  def boot args = nil; end

  # Called before `tick` when `Kernel.tick_count == 0`. Only available in `Main`.
  # @param args [GTK::Args]
  # @return [void]
  def start args = nil; end

  # Called every frame (60 times a second). Takes precedence over a
  # top-level `tick`.
  # @param args [GTK::Args]
  # @return [void]
  def tick args = nil; end

  # Called when `DR.reset` is invoked, before the reset happens.
  # @param args [GTK::Args]
  # @return [void]
  def reset args = nil; end

  # Called after DragonRuby's internal reset completes (see `reset`).
  # @param args [GTK::Args]
  # @return [void]
  def did_reset args = nil; end

  # Called before the game exits, and as part of `DR.reboot`.
  # @param args [GTK::Args]
  # @return [void]
  def shutdown args = nil; end
end
