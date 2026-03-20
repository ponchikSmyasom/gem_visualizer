require 'rspec'
require '../lib/gem_visualizer'

describe GemVisualizer::ProgressBar do
    it 'correctly progress bar' do
        bar = GemVisualizer::ProgressBar.new(50, 100)
        expect(bar.progress).to eq("[#{"=" * 50}>#{"." * 49}]")
    end
end