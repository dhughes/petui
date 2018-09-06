# frozen_string_literal: true

require 'io/console/size'

module Petui
  module Component
    class Container
      attr_accessor :children, :buffer

      def initialize
        @children = {}
        resize_buffer
      end

      def resize_buffer
        self.buffer = Array.new(IO.console_size[1]).map do |_y|
          Array.new(IO.console_size[0]).map { |_x| ' ' }
        end
      end

      def render(resize = true)
        resize_buffer if resize
        children.each do |child, position|
          apply_text_at_position(child.render, position)
        end
        buffer_string
      end

      def add_child(child, position)
        children[child] = position
      end

      private

      def buffer_string
        buffer.map(&:join).map(&:rstrip).join("\n")
      end

      def apply_text_at_position(text, position)
        to_matrix(text).each_with_index do |row, y|
          row.each_with_index do |cell, x|
            buffer[y + position[:y]][x + position[:x]] = cell
          end
        end

        buffer
      end

      def to_matrix(text)
        text.split("\n").map { |row| row.split('') }
      end
    end
  end
end
