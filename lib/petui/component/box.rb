# frozen_string_literal: true

require 'pry-byebug'

module Petui
  module Component
    class Box
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
        (1..self.height).map do |y|
          if y == 1
            [TOP_LEFT] + Array.new((width - 2), HORIZONTAL) + [TOP_RIGHT]
          elsif y == height
            [BOTTOM_LEFT] + Array.new((width - 2), HORIZONTAL) + [BOTTOM_RIGHT]
          else
            [VERTICAL] + Array.new((width - 2), ' ') + [VERTICAL]
          end
        end
      end

    end


  end
end