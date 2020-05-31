module Docs
  class Pytorch
    class EntriesFilter < Docs::EntriesFilter
      def get_name
        name = at_css('h1').content
        puts 'name!'
        puts name
        name
      end

      def get_type
        at_css('h1').content
      end

      def additional_entries
        return [] if root_page?

        css('h1, dt').each_with_object [] do |node, entries|
          name = node['id']
          type = nil

          # not sure what type means
          case node.parent['class']
          when 'function'
              type = 'function'
          when 'class'
              type = 'class'
          end
          entries << [name, node['id'], type] unless name == self.name or name == nil
        end
      end
    end
  end
end
