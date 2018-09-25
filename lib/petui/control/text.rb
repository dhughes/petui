# frozen_string_literal: true

module Petui
  module Control
    class Text
      include Styleable

      attr_accessor :width, :minimum_width, :maximum_width, :minimum_height, :maximum_height, :scroll_top
      attr_reader :text
      attr_writer :preferred_width, :preferred_height

      def initialize(text)
        @text = text
        @minimum_width = 2
        @preferred_width = text.length
        @maximum_width = nil
        @minimum_height = 1
        @preferred_height = nil
        @maximum_height = nil
        @scroll_top = 0
      end

      def preferred_width
        @preferred_width > minimum_width ? @preferred_width : minimum_width
      end

      def preferred_height
        if @preferred_height.nil?
          calculate_height(preferred_width)
        else
          @preferred_height > minimum_height ? @preferred_height : minimum_height
        end
      end

      def render(width: preferred_width, height: calculate_height(width))
        take_lines(wrapped_text(width), height)
      end

      private

      def calculate_height(width)
        wrapped_text(width).split("\n").size
      end

      def take_lines(source_text, to_line)
        source_text.split("\n").drop(scroll_top).take(to_line).join("\n")
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
