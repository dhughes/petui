# frozen_string_literal: true

require 'pry-byebug'
require 'petui/component/container'

module Petui
  module Component
    class Box < Container
      attr_accessor :width, :height

      HORIZONTAL = '─'
      VERTICAL = '│'
      TOP_LEFT = '┌'
      TOP_RIGHT = '┐'
      BOTTOM_LEFT = '└'
      BOTTOM_RIGHT = '┘'

      def initialize(width:, height:)
        @width = width
        @height = height
      end

      def render
        "#{top}" \
        "#{middle}" \
        "#{bottom}"
      end

      private

      def horizontal_side
        HORIZONTAL * (width - 2)
      end

      def top
        "#{TOP_LEFT}#{horizontal_side}#{TOP_RIGHT}\n"
      end

      def middle
        "#{VERTICAL}#{empty_space}#{VERTICAL}\n" * (width - 2)
      end

      def empty_space
        ' ' * (width - 2)
      end

      def bottom
        "#{BOTTOM_LEFT}#{horizontal_side}#{BOTTOM_RIGHT}"
      end
    end
  end
end
