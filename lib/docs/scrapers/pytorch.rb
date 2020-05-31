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

    html_filters.push 'sphinx/clean_html', 'pytorch/entries'

    options[:container] = ->(filter) { '.pytorch-container'}
    options[:skip] = %w(tutorial/statistical_inference/finding_help.html)
    options[:only_patterns] = [/\Amodules/, /\Adatasets/, /\Atutorial/, /\Aauto_examples/]
    options[:skip_patterns] = [/\Acommunity/]
    options[:max_image_size] = 256_000

    options[:attribution] = <<-HTML
    &copy; 2010&ndash;2019 JetBrains s.r.o.<br>
    Licensed under the Apache License, Version 2.0.
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
  