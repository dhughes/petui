# frozen_string_literal: true

require 'paint'

module Petui
  module Control
    class ProgressBar
      include Styleable

      attr_accessor :preferred_width, :width, :minimum_width, :progress

      PREFERRED_WIDTH = 10

      def initialize
        @preferred_width = PREFERRED_WIDTH
        @width = preferred_width
        @minimum_width = width
        @progress = 0
      end

      def render
        output = slices.each_slice(8).map { |block| block.count(1) }.reduce('') do |progress, block|
          progress + render_block(block)
        end
        style(output)
      end

      private

      def slices
        Array.new(filled_slices, 1) + Array.new(blank_slices, 0)
      end

      def total_slices
        width * 8
      end

      def filled_slices
        (total_slices * progress).floor
      end

      def blank_slices
        total_slices - filled_slices
      end

      def render_block(block)
        case block
        when 0
          ' '
        when 1
          '▏'
        when 2
          '▎'
        when 3
          '▍'
        when 4
          '▌'
        when 5
          '▋'
        when 6
          '▊'
        when 7
          '▉'
        when 8
          '█'
        end
      end
    end
  end
end
