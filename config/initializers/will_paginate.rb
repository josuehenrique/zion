require 'will_paginate/view_helpers/action_view'

module WillPaginate
  module ActionView
    def will_paginate(collection = nil, options = {})
      options[:renderer] ||= BootstrapLinkRenderer
      super.try :html_safe
    end

    class BootstrapLinkRenderer < LinkRenderer
      protected

      def html_container(html)
        tag(:div, tag(:ul, html, class: 'pagination'), class: 'dataTables_paginate paging_bootstrap', style: 'float: right')
      end

      def page_number(page)
        tag :li, link(page, page, rel: rel_value(page)), class: ('active' if page == current_page)
      end

      def previous_or_next_page(page, text, classname)
        case classname
          when 'next_page' then text = "<i class='fa fa-angle-double-right'></i>"
          when 'previous_page' then text = "<i class='fa fa-angle-double-left'></i>"
        end
        tag :li, link(text, page || '#'), class: [classname[0..3], classname, ('disabled' unless page)].join(' ')
      end

      def gap
        tag :li, link(super, '#'), class: 'disabled'
      end
    end
  end
end

module RemotePaginator
  class LinkRenderer < WillPaginate::ActionView::LinkRenderer
    protected

    def html_container(html)
      tag(:div, tag(:ul, html, class: 'pagination'), class: 'dataTables_paginate paging_bootstrap')
    end

    def page_number(page)
      tag :li, link(page, page, rel: rel_value(page)), class: ('active' if page == current_page)
    end

    def previous_or_next_page(page, text, classname)
      case classname
        when 'next_page' then text = "<i class='fa fa-angle-double-right'></i>"
        when 'previous_page' then text = "<i class='fa fa-angle-double-left'></i>"
      end
      tag :li, link(text, page || '#'), class: [classname[0..3], classname, ('disabled' unless page)].join(' ')
    end

    def gap
      tag :li, link(super, '#'), class: 'disabled'
    end

    private

    def link(text, target, attributes = {})
      attributes["data-remote"] = true #This is added
      super
    end
  end
end
