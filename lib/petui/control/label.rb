# frozen_string_literal: true

module Petui
  module Control
    class Label
      include Styleable

      attr_accessor :width, :minimum_width, :maximum_width, :align
      attr_reader :text
      attr_writer :preferred_width

      def initialize(text)
        @text = text
        @minimum_width = 2
        @preferred_width = text.length
        @maximum_width = nil
        @align = Petui::Position::LEFT
      end

      def render(width: preferred_width)
        raise 'Width less than minimum.' if width < minimum_width
        raise 'Width greater than maximum.' if maximum_width && width > maximum_width

        output = if text.length > width
                   render_short(width: width)
                 else
                   render_long(width: width)
                 end
        style(output)
      end

      def preferred_width
        @preferred_width > minimum_width ? @preferred_width : minimum_width
      end

      private

      def render_short(width:)
        "#{text.slice(0..width - 2)}…"
      end

      def render_long(width:)
        case align
        when Petui::Position::LEFT
          text.ljust(width)
        when Petui::Position::CENTER
          text.center(width)
        when Petui::Position::RIGHT
          text.rjust(width)
        else
          text
        end
      end
    end
  end
end
