# frozen_string_literal: true

require 'paint'

module Petui
  module Control
    class ProgressBar
      include Styleable

      attr_accessor :width, :minimum_width, :preferred_width, :maximum_width, :progress

      PREFERRED_WIDTH = 10

      def initialize
        @minimum_width = 1
        @preferred_width = PREFERRED_WIDTH
        @maximum_width = nil
        @progress = 0
      end

      def render(width: preferred_width)
        output = slices(width: width).each_slice(8).map { |block| block.count(1) }.reduce('') do |progress, block|
          progress + render_block(block)
        end
        style(output)
      end

      private

      def slices(width:)
        Array.new(filled_slices(width: width), 1) + Array.new(blank_slices(width: width), 0)
      end

      def total_slices(width:)
        width * 8
      end

      def filled_slices(width:)
        (total_slices(width: width) * progress).floor
      end

      def blank_slices(width:)
        total_slices(width: width) - filled_slices(width: width)
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
