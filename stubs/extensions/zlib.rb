# Compresses and uncompresses strings.
module Zlib
  class << self
    # @param string [String]
    # @return [String] compressed data
    def compress string; end

    # Same as #compress.
    #
    # @param string [String]
    # @return [String]
    def deflate string; end

    # @param string [String] data returned by #compress
    # @return [String] the original string
    def uncompress string; end

    # Same as #uncompress.
    #
    # @param string [String]
    # @return [String]
    def inflate string; end
  end
end
