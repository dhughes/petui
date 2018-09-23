# frozen_string_literal: true

module Petui
  module Control
    class Text
      include Styleable

      attr_accessor :width, :minimum_width, :maximum_width, :preferred_height, :scroll_top
      attr_reader :text
      attr_writer :preferred_width

      def initialize(text)
        @text = text
        @minimum_width = 2
        @preferred_width = text.length
        @maximum_width = nil

        @preferred_height = nil

        @scroll_top = 0
      end

      def preferred_width
        @preferred_width > minimum_width ? @preferred_width : minimum_width
      end

      def render(width: preferred_width, height: preferred_height)
        output = wrapped_text(width)
        output = take_lines(output, height) if height
        output
      end

      private

      def take_lines(text, to_line)
        text.split("\n").drop(scroll_top).take(to_line).join("\n")
      end

      def wrapped_text(width)
        text.split("\n").
          map { |line| wrap_line(line, width) }.
          join("\n")
      end

      def wrap_line(line, width)
        line = line.split(' ').reduce([]) do |words, word|
          if word.length <= width
            words << word
          else
            words + word.scan(/.{1,#{width}}/)
          end
        end.join(' ')

        line.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n").strip
      end
    end
  end
end
