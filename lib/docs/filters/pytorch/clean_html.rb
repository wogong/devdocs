module Docs
  class Pytorch
    class CleanHtmlFilter < Filter
      def call
        @doc = at_css('.pytorch-article')
        doc
      end
    end
  end
end
