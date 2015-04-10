module Jekyll
  class URL
    # override
    def generate_url(template)
      @placeholders.inject(template) do |result, token|
        break result if result.index(':').nil?
        #result.gsub(/:#{token.first}/, self.class.escape_path(token.last))
        result.gsub(/:#{token.first}/, token.last)
      end
    end
  end
end
