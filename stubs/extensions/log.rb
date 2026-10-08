# Logging functions available everywhere. Output goes to the console and
# the log file.
class Object
  # Logs `args`, like `puts`.
  #
  # @return [void]
  def log *args; end

  # Logs `args` without a trailing newline.
  #
  # @return [void]
  def log_print *args; end

  # Logs `args` as an important, highlighted message.
  #
  # @return [void]
  def log_important *args; end

  # Logs `args` at the info level.
  #
  # @return [void]
  def log_info *args; end

  # Logs `args` at the error level.
  #
  # @return [void]
  def log_error *args; end

  # Logs `str` at the spam level.
  #
  # @param str [String]
  # @param subsystem [String, nil]
  # @return [void]
  def log_spam str, subsystem = nil; end

  # Logs `str` at the debug level.
  #
  # @param str [String]
  # @param subsystem [String, nil]
  # @return [void]
  def log_debug str, subsystem = nil; end

  # Logs `str` at the warn level.
  #
  # @param str [String]
  # @param subsystem [String, nil]
  # @return [void]
  def log_warn str, subsystem = nil; end

  # Logs `str` at the unfiltered level.
  #
  # @param str [String]
  # @param subsystem [String, nil]
  # @return [void]
  def log_unfiltered str, subsystem = nil; end

  # Logs `message` only the first time it's called with these `ids`.
  #
  # @example
  #   log_once :low_health, "health is low"
  #
  # @param ids [Array<Symbol, String>]
  # @param message [String]
  # @param include_caller [Boolean] also log the backtrace
  # @param raise_if [Boolean] raise `message` instead of logging it
  # @return [void]
  def log_once *ids, message, include_caller: false, raise_if: false; end

  # Like #log_once, as an important message.
  #
  # @return [void]
  def log_once_important *ids, message, include_caller: false; end

  # Like #log_once, at the info level.
  #
  # @return [void]
  def log_once_info *ids, message, include_caller: false; end

  # Logs `args` in black.
  #
  # @return [void]
  def log_black *args; end

  # Logs `args` in red.
  #
  # @return [void]
  def log_red *args; end

  # Logs `args` in green.
  #
  # @return [void]
  def log_green *args; end

  # Logs `args` in yellow.
  #
  # @return [void]
  def log_yellow *args; end

  # Logs `args` in blue.
  #
  # @return [void]
  def log_blue *args; end

  # Logs `args` in magenta.
  #
  # @return [void]
  def log_magenta *args; end

  # Logs `args` in cyan.
  #
  # @return [void]
  def log_cyan *args; end

  # Logs `args` in white.
  #
  # @return [void]
  def log_white *args; end

  # Logs `args` in bright black.
  #
  # @return [void]
  def log_bright_black *args; end

  # Logs `args` in bright red.
  #
  # @return [void]
  def log_bright_red *args; end

  # Logs `args` in bright green.
  #
  # @return [void]
  def log_bright_green *args; end

  # Logs `args` in bright yellow.
  #
  # @return [void]
  def log_bright_yellow *args; end

  # Logs `args` in bright blue.
  #
  # @return [void]
  def log_bright_blue *args; end

  # Logs `args` in bright magenta.
  #
  # @return [void]
  def log_bright_magenta *args; end

  # Logs `args` in bright cyan.
  #
  # @return [void]
  def log_bright_cyan *args; end

  # Logs `args` in bright white.
  #
  # @return [void]
  def log_bright_white *args; end
end
