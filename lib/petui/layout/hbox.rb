# frozen_string_literal: true

module Petui
  module Layout
    class HBox
      attr_accessor :width, :children

      def initialize
        @width = 0
        @children = []
      end

      def render
        output = children.reduce('') do |output, child|
          child.width = (child.preferred_width * scale).round
          output + child.render
        end

        output = output + ' ' * (width - output.length) if width - output.length > 0
        
        output
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

      def scale
        total_preferred_width > width ? width / total_preferred_width.to_f : width
      end


    end
  end
end
