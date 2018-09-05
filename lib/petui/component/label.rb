# frozen_string_literal: true

module Petui
  module Component
    class Label
      attr_accessor :text

      def initialize(text)
        @text = text
      end

      def render
        [text.split('')]
      end
    end
  end
end