# frozen_string_literal: true

module Petui
  module Styleable
    attr_accessor :color, :background_color, :styles

    @color = nil
    @background_color = nil
    @styles = []

    def style(text)
      styled? ? Paint[text, color, background_color, *styles] : text
    end

    def styled?
      color || background_color || styles&.size
    end
  end
end
