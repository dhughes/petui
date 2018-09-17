# frozen_string_literal: true

module Petui
  module Layout
    class HBox
      attr_accessor :width, :children
      attr_writer :preferred_width

      def initialize
        @preferred_width = nil
        @maximum_width = nil
        @children = []
      end

      def render(width: preferred_width)
        output = children.reduce('') do |output, child|
          child_width = (child.preferred_width * scale(width)).round
          output + child.render(width: child_width)
        end

        output += ' ' * (width - output.length) if (width - output.length).positive?

        output
      end

      def minimum_width
        children.reduce(0) do |minimum, child|
          minimum + child.minimum_width
        end
      end

      def preferred_width
        return minimum_width if @preferred_width.nil? || minimum_width > @preferred_width
        @preferred_width
      end

      private

      # def inflexible_width
      #   children.select { |child| child.minimum_width > child.preferred_width }.
      #     reduce(0) { |sum, child| sum + child.minimum_width }
      # end

      def total_preferred_width
        children.reduce(0) do |total, child|
          width = child.preferred_width > child.minimum_width ? child.preferred_width : child.minimum_width
          total + width
        end
      end

      def scale(width)
        total_preferred_width > width ? width / total_preferred_width.to_f : 1
      end
    end
  end
end
