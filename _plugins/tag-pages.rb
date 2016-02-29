require 'byebug'

module Jekyll

  class TagIndex < Page
    def initialize(site, base, dir, tag, tag_pages)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag-index.html')
      self.data['tag'] = tag
      tag_title_prefix = site.config['tag_title_prefix'] || 'List of pages tagged \''
      tag_title_suffix = site.config['tag_title_suffix'] || '\''
      self.data['title'] = "#{tag_title_prefix}#{tag}#{tag_title_suffix}"
      self.data['tag_pages'] = tag_pages
    end
  end

  class TagGenerator < Generator
    def generate(site)
      # if no tag index page layout found, do nothing
      unless site.layouts.key? 'tag-index'
        return
      end
      dir = site.config['tag_dir'] || 'tag'

      tags = Hash.new(Array.new)
      site.collections['wiki'].docs.each do |page|
        page.data['tags'].each do |tag|
          # if tag is new, create an array for it
          unless tags.has_key?(tag)
            tags[tag] = Array.new
          end
          page_info = { 'guessed_name' => File.basename(page.relative_path, '.md'), 'url' => page.url }
          tags[tag] << page_info
        end
      end
      tags.each do |tag_name, tag_pages|
        write_tag_index(site, File.join(dir, tag_name), tag_name, tag_pages)
      end
    end

    def write_tag_index(site, dir, tag, tag_pages)
      index = TagIndex.new(site, site.source, dir, tag, tag_pages)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end

end
