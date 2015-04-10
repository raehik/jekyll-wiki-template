#!/usr/bin/env ruby
#
# Set title from filename for a collection if not present.
#

module Jekyll
  class TitleTest < Generator
    def generate(site)
      collection = "wiki"
      title_key = "title"
      ext = ".md"

      # loop through each page in the collection
      site.collections[collection].docs.each do |page|
        unless page.data.key?(title_key)
          # if no title set in file, set it to the filename without
          # extension
          page.data[title_key] = File.basename(page.path, ext)
        end
      end
    end
  end
end
