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
      filled_count = [@total - 1, 0].max
      empty_count = [@bar_width - @total, 0].max
      "[#{"=" * filled_count}>#{"." * empty_count}] %#{@total}"
    end

    def update(progress)
      @total += progress
    end

    def update_line(text)
      STDOUT.print "\r\e[2K#{text}"
      STDOUT.flush
    end
  end
end