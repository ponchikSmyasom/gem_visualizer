require 'rspec'
require '../lib/gem_visualizer'

describe GemVisualizer::ProgressBar do
    it 'Progress bar is showing?' do
        bar = GemVisualizer::ProgressBar.new(50, 100)
        expect(bar.total_show).to eq("[#{"=" * 49}>#{"." * 50}] %50")
    end
end

describe GemVisualizer::ProgressBar do
    it 'Progress bar is updateing?' do
        bar = GemVisualizer::ProgressBar.new(50, 100)
        expect(bar.total_show).to eq("[#{"=" * 49}>#{"." * 50}] %50")

        bar.update(10)
        expect(bar.total_show).to eq("[#{"=" * 59}>#{"." * 40}] %60")

        bar.update(40)
        expect(bar.total_show).to eq("[#{"=" * 99}>#{"." * 0}] %100")
    end
end