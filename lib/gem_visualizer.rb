# frozen_string_literal: true

require_relative "gem_visualizer/version"

module GemVisualizer
  class Error < StandardError; end

  class ProgressBar
    def initialize(total, bar_width)
      @total = [total, 0].max
      @bar_width = [bar_width, 1].max
    end

    def total_show
      filled_count = [@total - 1, 0].max
      empty_count = [@bar_width - @total, 0].max
      "[#{"=" * filled_count}>#{"." * empty_count}] %#{@total * 100 / @bar_width}"
    end

    def update(progress)
      if progress < 0
        @total += 0
      elsif (progress + @total) > @bar_width
        @total = @bar_width
      else
        @total += progress
      end
    end

    def update_line(text)
      STDOUT.print "\r\e[2K#{text}"
      STDOUT.flush
    end
  end
end