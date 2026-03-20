# frozen_string_literal: true

require_relative "gem_visualizer/version"

module GemVisualizer
  class Error < StandardError; end
  class ProgressBar
    def initialize(total, bar_width)
      @total = total
      @bar_width = bar_width
    end

    def progress
      "[#{"=" * @total}>#{"." * (@bar_width - @total - 1)}]"
    end
  end
end