module Jekyll
  module Commands
    class Serve
      class << self
        alias :_original_webrick_options :webrick_options
      end
      # override options to serve UTF-8 by default (because most of my
      # content is UTF-8, so now text files will be served correctly)
      def self.webrick_options(config)
        options = _original_webrick_options(config)
        options[:MimeTypes].merge!({'html' => 'text/html; charset=utf-8'})
        options[:MimeTypes].merge!({'txt' => 'text/plain; charset=utf-8'})
        options
      end
    end
  end
end
