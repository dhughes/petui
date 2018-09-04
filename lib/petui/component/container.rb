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

      def render
        IO.console_size
        children.each do |child, position|
          child.render.each do |row|
            current_x = nil
            current_y = current_y ? current_y + 1 : position[:y]
            row.each do |letter|
              current_x = current_x ? current_x + 1 : position[:x]
              buffer[current_y][current_x] = letter
            end
          end
        end
        buffer.map(&:join).join("\n")
      end

      def add_child(child, position)
        children[child] = position
      end
    end
  end
end
