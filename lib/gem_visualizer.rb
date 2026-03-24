# frozen_string_literal: true

require_relative "gem_visualizer/version"

module GemVisualizer
  class Error < StandardError; end
  
  class ProgressBar
    def initialize(total, bar_width)
      @total = total
      @bar_width = bar_width
    end

    def total_show
      "[#{"=" * (@total-1)}>#{"." * (@bar_width - @total)}] %#{@total}"
    end
    
    def update(progress)
      @total += progress;
    end
  end
end