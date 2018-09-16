# frozen_string_literal: true

module Petui
  module Control
    class ProgressBar < Control

      attr_accessor :width, :progress

      def initialize
        @width = nil
        @progress = 0
      end

      def render
        full = '█' * full_blocks
        blank = ' ' * blank_blocks
        "#{full}#{partial}#{blank}"
      end

      private

      def partial
        case partial_block
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
        end
      end

      # 8 slices to a block
      def full_blocks
        (full_slices / 8.0).floor
      end

      def blank_blocks
        (blank_slices / 8.0).floor
      end

      def partial_block
        full_slices % 8
      end

      def full_slices
        (total_slices * progress).floor
      end

      def blank_slices
        total_slices - full_slices
      end

      def total_slices
        width * 8
      end
    end
  end
end
