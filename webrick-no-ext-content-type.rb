require "webrick"

module WEBrick
  module HTTPUtils
    class << self
      alias_method :default_mime_type, :mime_type

      def mime_type(filename, mime_tab)
        # as far as I can tell: if file has no extension, append '.html'
        filename = ((/\.(\w+)$/ =~ filename) ? filename : filename + '.html')

        # then continue getting mime type from filename (so if it had no
        # extension, it's treated as HTML)
        default_mime_type(filename, mime_tab)
      end
    end
  end
end 
