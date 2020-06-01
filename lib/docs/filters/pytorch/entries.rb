module Docs
  class Pytorch
    class EntriesFilter < Docs::EntriesFilter
      def get_name
        name = at_css('h1').content
        name
      end

      def get_type
        at_css('h1').content
      end

      def additional_entries
        return [] if root_page?

        entries = []

        css('dt').each do |node|
          name = node['id']
          if name == self.name or name == nil
            next
          end

          # TODO: classmethod
          case node.parent['class']
          when 'function'
            entries << [name + '()', node['id'], nil]
          when 'class', 'attribute'
            entries << [name, node['id'], nil]
          end
        end

        css('dt').each do |node|
          name = node['id']
          if name == self.name or name == nil
            next
          end

          case node.parent['class']
          when 'function'
            entries << [name + '()', node['id']]
          when 'class', 'attribute'
            entries << [name, node['id']]
          end
        end

        entries
      end
    end
  end
end
