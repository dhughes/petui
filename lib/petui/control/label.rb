# frozen_string_literal: true

module Petui
  module Control
    class Label < Control
      include Styleable

      attr_accessor :width, :min_width, :max_width, :align
      attr_reader :text

      def initialize(text)
        @text = text
        @width = text.length
        @min_width = nil
        @max_width = nil
        @align = Petui::Position::LEFT
      end

      def render
        output = if text.length > width
                   render_short
                 else
                   render_long
                 end
        style(output)
      end

      private

      def render_short
        raise 'Width must be at least 2' if width - 2 < 2
        "#{text.slice(0..width - 2)}…"
      end

      def render_long
        case align
        when Petui::Position::LEFT
          text.ljust(width)
        when Petui::Position::CENTER
          text.center(width)
        when Petui::Position::RIGHT
          text.rjust(width)
        end
      end
    end
  end
end
