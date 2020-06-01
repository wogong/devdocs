module Docs
  class Pytorch < UrlScraper
    self.name = 'PyTorch'
    self.slug = 'pytorch'
    self.type = 'sphinx'
    self.release = '1.5.0'
    self.base_url = 'https://pytorch.org/docs/stable/'
    self.force_gzip = true
    self.links = {
      home: 'https://pytorch.org/',
      code: 'https://github.com/pytorch/pytorch'
    }

    html_filters.push 'sphinx/clean_html', 'pytorch/clean_html', 'pytorch/entries'

    options[:skip] = ['cpp_index.html', 'packages.html', 'py-modindex.html', 'genindex.html']
    options[:skip_patterns] = [/\Acommunity/, /\A_modules/, /\Anotes/, /\Aorg\/pytorch\//, /\Arpc\//]
    options[:max_image_size] = 256_000

    options[:attribution] = <<-HTML
    &copy; 2019 Torch Contributors<br>
    Licensed under the 3-clause BSD License.<br>
    <a href="https://github.com/pytorch/pytorch/blob/master/LICENSE" class="_attribution-link">Read the full license.</a>
    HTML

    def get_latest_version(opts)
      doc = fetch_doc('https://pytorch.org/docs/versions.html', opts)
      doc.css('li .toctree-l1').each do |node|
          match = /\Av(.+?) \(stable release\)/.match(node.content)
          if match
              return match[1]
          end
      end
    end
  end
end
  