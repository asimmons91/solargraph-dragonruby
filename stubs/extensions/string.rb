class String
  # Splits self into lines of at most `length` characters, breaking at word
  # boundaries (or at characters when self has multibyte characters).
  #
  # @param length [Integer]
  # @return [Array<String>]
  def wrapped_lines length; end

  # @param length [Integer]
  # @return [String] self with newlines inserted so no line exceeds `length` characters
  def wrap length; end

  # @return [Boolean] true if self contains a newline
  def multiline?; end

  # @param amount [Integer]
  # @param char [String]
  # @return [String] self with every line but the first indented by `amount` `char`s
  def indent_lines amount, char = " "; end

  # @param count [Integer]
  # @param indent_char [String]
  # @param pad_line_with_space [Boolean]
  # @return [String] self with every line indented by `count` `indent_char`s
  def indent count, indent_char: "  ", pad_line_with_space: false; end

  # @return [String] self wrapped in double quotes
  def quote; end

  # @return [String] same as #strip
  def trim; end

  # @return [String, nil] same as #strip!
  def trim!; end

  # @return [String] same as #lstrip
  def ltrim; end

  # @return [String, nil] same as #lstrip!
  def ltrim!; end

  # @return [String] same as #rstrip
  def rtrim; end

  # @return [String, nil] same as #rstrip!
  def rtrim!; end

  # @return [Integer, nil] byte value of the first character
  def char_byte; end

  # @param index [Integer]
  # @param char [String]
  # @return [String] a copy of self with `char` inserted at `index`
  def insert_character_at index, char; end

  # @param index [Integer]
  # @return [String] a copy of self without the character at `index`
  def excluding_character_at index; end

  # @return [String] a copy of self without its last character
  def excluding_last_character; end

  class << self
    # @param string [String]
    # @param length [Integer]
    # @return [Array<String>] see String#wrapped_lines
    def wrapped_lines string, length; end

    # Vertical anchors for centering lines of text on a point: pass the
    # result as each label's `anchor_y`.
    #
    # @example
    #   String.line_anchors(["one", "two"]).map do |anchor, text|
    #     { x: 640, y: 360, text: text, anchor_x: 0.5, anchor_y: anchor }
    #   end
    #
    # @param line_count_or_strings [Integer, Array<String>]
    # @return [Array<Float>, Array<Array(Float, String)>] anchors, or `[anchor, string]` pairs when given strings
    def line_anchors line_count_or_strings; end

    # @param str [String]
    # @return [Array<String>] the UTF-8 characters of `str`
    def utf8_chars str; end
  end
end
