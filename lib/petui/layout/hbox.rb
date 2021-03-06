# frozen_string_literal: true

module Petui
  module Layout
    class HBox
      attr_accessor :width, :children, :padding, :spacing, :maximum_width, :align
      attr_writer :preferred_width, :minimum_width

      def initialize
        @minimum_width = 0
        @preferred_width = nil
        @maximum_width = nil
        @padding = 0
        @spacing = 1
        @children = []
        @align = Petui::Position::LEFT
      end

      def render(width: preferred_width)
        rendered_children = render_children(width: width)
        left_spaces = left_offset_spaces(width)
        right_spaces = right_offset_spaces(width)
        "#{padding_spaces}#{left_spaces}#{rendered_children.join(spacing_spaces)}#{right_spaces}#{padding_spaces}"
      end

      def minimum_width
        calculated_minimum = minimum_children_widths.reduce(0, &:+) + padding_width + spacing_width
        calculated_minimum > @minimum_width ? calculated_minimum : @minimum_width
      end

      def preferred_width
        return minimum_width if @preferred_width && @preferred_width < minimum_width
        return maximum_width if @preferred_width && maximum_width && @preferred_width > maximum_width
        @preferred_width || 0
      end

      private

      def left_offset_spaces(width)
        ' ' * left_offset(width)
      end

      def right_offset_spaces(width)
        ' ' * right_offset(width)
      end

      def left_offset(width)
        case align
        when Petui::Position::CENTER
          (usable_width(width: width) - content_width(width: width)) / 2
        when Petui::Position::RIGHT
          usable_width(width: width) - content_width(width: width)
        else
          0
        end
      end

      def right_offset(width)
        usable_width(width: width) - left_offset(width) - content_width(width: width)
      end

      def padding_spaces
        ' ' * padding
      end

      def spacing_spaces
        ' ' * spacing
      end

      def render_children(width:)
        adjusted_children_widths(width: width).map { |child, width| child.render(width: width) }
      end

      def adjusted_children_widths(width:, adjusted_children_widths: Hash[children.zip(preferred_children_widths)])
        extra_width = extra_width(width, adjusted_children_widths.values)
        return adjusted_children_widths if extra_width.zero?
        adjustable_children = adjustable_children(extra_width, adjusted_children_widths)
        return adjusted_children_widths if adjustable_children.empty?
        amount_to_change = extra_width / adjustable_children.size
        return adjusted_children_widths if amount_to_change.zero?

        adjustable_children.each do |child, width|
          adjusted_children_widths[child] = adjusted_width(child, width, amount_to_change)
        end
        adjusted_children_widths(width: width, adjusted_children_widths: adjusted_children_widths)
      end

      def adjusted_width(child, width, amount_to_change)
        adjusted_width = width + amount_to_change
        if child.maximum_width && adjusted_width > child.maximum_width
          child.maximum_width
        elsif adjusted_width < child.minimum_width
          child.minimum_width
        else
          adjusted_width
        end
      end

      def adjustable_children(extra_width, adjusted_children_widths)
        if extra_width.negative?
          adjusted_children_widths.select { |child, width| child.minimum_width < width }
        elsif extra_width.positive?
          adjusted_children_widths.select do |child, width|
            child.maximum_width.nil? || child.maximum_width > width
          end
        end
      end

      def extra_width(width, adjusted_widths)
        width - adjusted_widths.reduce(0, &:+) - spacing_width
      end

      def content_width(width:)
        adjusted_children_widths(width: width).reduce(0) do |sum, (_, width)|
          sum + width
        end + spacing_width
      end

      def preferred_content_width
        preferred_children_widths.reduce(0, &:+) + spacing_width
      end

      def spacing_width
        return 0 if children.empty?
        spacing * (children.size - 1)
      end

      def preferred_children_widths
        children.map(&:preferred_width)
      end

      def minimum_children_widths
        children.map(&:minimum_width)
      end

      def usable_width(width:)
        width - padding_width
      end

      def padding_width
        padding * 2
      end
    end
  end
end
