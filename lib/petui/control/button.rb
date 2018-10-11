# frozen_string_literal: true

module Petui
  module Control
    class Button
      include Styleable

      attr_accessor :focused #:width, :minimum_width, :maximum_width, :minimum_height, :maximum_height, :scroll_top
      attr_reader :text
      attr_writer :preferred_width, :preferred_height

      def initialize(text)
        @text = text
        # @minimum_width = 2
        @preferred_width = text.length + 2
        # @maximum_width = nil
        # @minimum_height = 1
        # @preferred_height = nil
        # @maximum_height = nil
        # @scroll_top = 0
      end

      def render(width: nil)
        wrap_text
      end

      private

      def wrap_text
        wrapped = []
        wrapped << "#{top_left_corner}#{horizontal_line}#{top_right_corner}"
        wrapped << "#{vertical_line}#{text}#{vertical_line}"
        wrapped << "#{bottom_left_corner}#{horizontal_line}#{bottom_right_corner}"
        wrapped.join("\n")
      end

      def horizontal_line
        (focused ? '═' : '─') * text.length
      end

      def vertical_line
        focused ? '║' : '│'
      end

      def top_left_corner
        focused ? '╔' : '┌'
      end

      def top_right_corner
        focused ? '╗' : '┐'
      end

      def bottom_left_corner
        focused ? '╚' : '└'
      end

      def bottom_right_corner
        focused ? '╝' : '┘'
      end
    end
  end
end