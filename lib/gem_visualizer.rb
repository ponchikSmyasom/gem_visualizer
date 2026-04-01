# frozen_string_literal: true

require_relative "gem_visualizer/version"

module GemVisualizer
  class Error < StandardError; end

  class ProgressBar
    def initialize(total, bar_width, labels: {})
      @total = [total, 0].max
      @bar_width = [bar_width, 1].max
      @start_time = Time.now
      @initial_total = @total
      @labels = default_labels.merge(labels)
    end

    def total_show
      filled_count = [@total - 1, 0].max
      empty_count = [@bar_width - @total, 0].max
      "[#{"=" * filled_count}>#{"." * empty_count}] %#{@total * 100 / @bar_width}"
    end

    def eta_show
      return @labels[:done] if @total == @bar_width
      return "#{@labels[:prefix]} --" if @total == @initial_total

      elapsed = Time.now - @start_time
      progress_made = @total - @initial_total
      rate = progress_made.to_f / elapsed
      eta_seconds = (@bar_width - @total) / rate

      format_eta(eta_seconds)
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

    private

    def default_labels
      {
        prefix: "Осталось:",
        seconds: "сек",
        minutes: "мин",
        hours: "ч",
        done: "Готово!"
      }
    end

    def format_eta(seconds)
      prefix = @labels[:prefix]
      if seconds < 60
        "#{prefix} #{seconds.round} #{@labels[:seconds]}"
      elsif seconds < 3600
        m = (seconds / 60).floor
        s = (seconds % 60).round
        "#{prefix} #{m} #{@labels[:minutes]} #{s} #{@labels[:seconds]}"
      else
        h = (seconds / 3600).floor
        m = ((seconds % 3600) / 60).floor
        "#{prefix} #{h} #{@labels[:hours]} #{m} #{@labels[:minutes]}"
      end
    end
  end
end