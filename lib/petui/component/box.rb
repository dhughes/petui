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
        super()
        @width = width
        @height = height
      end

      def render(resize = true)
        resize_buffer if resize
        apply_text_at_position(border, x: 0, y: 0)
        super(false)
        buffer_string
      end

      def add_child(child, position)
        super(child, x: position[:x] + 1, y: position[:y] + 1)
      end

      private

      def border
        "#{top}" \
        "#{middle}" \
        "#{bottom}"
      end

      def horizontal_side
        HORIZONTAL * (width - 2)
      end

      def top
        "#{TOP_LEFT}#{horizontal_side}#{TOP_RIGHT}\n"
      end

      def middle
        "#{VERTICAL}#{empty_space}#{VERTICAL}\n" * (height - 2)
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