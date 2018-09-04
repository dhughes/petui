# frozen_string_literal: true

require 'petui/version'

$LOAD_PATH.unshift(File.dirname(__FILE__))

Dir[File.expand_path('petui/**/*.rb', __dir__)].each { |f| require f }

module Petui
  class UI
  end
end
