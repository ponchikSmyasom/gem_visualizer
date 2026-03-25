# frozen_string_literal: true

require 'spec_helper'
require 'gem_visualizer'

RSpec.describe GemVisualizer::ProgressBar do
  describe '#initialize' do
    it 'создаёт прогресс-бар с указанными total и bar_width' do
      bar = described_class.new(50, 100)

      expect(bar.instance_variable_get(:@total)).to eq(50)
      expect(bar.instance_variable_get(:@bar_width)).to eq(100)
    end

    it 'создаёт прогресс-бар с нулевым прогрессом' do
      bar = described_class.new(0, 100)

      expect(bar.instance_variable_get(:@total)).to eq(0)
      expect(bar.instance_variable_get(:@bar_width)).to eq(100)
    end

    it 'создаёт прогресс-бар с максимальным прогрессом' do
      bar = described_class.new(100, 100)

      expect(bar.instance_variable_get(:@total)).to eq(100)
      expect(bar.instance_variable_get(:@bar_width)).to eq(100)
    end
  end

  describe '#total_show' do
    context 'когда прогресс 0%' do
      it 'показывает пустой прогресс-бар' do
        bar = described_class.new(0, 100)

        expect(bar.total_show).to eq("[>#{"." * 100}] %0")
      end
    end

    context 'когда прогресс 50%' do
      it 'показывает половину заполненный прогресс-бар' do
        bar = described_class.new(50, 100)

        expect(bar.total_show).to eq("[#{"=" * 49}>#{"." * 50}] %50")
      end
    end

    context 'когда прогресс 100%' do
      it 'показывает полностью заполненный прогресс-бар' do
        bar = described_class.new(100, 100)

        expect(bar.total_show).to eq("[#{"=" * 99}>] %100")
      end
    end

    context 'когда прогресс 25%' do
      it 'показывает четверть заполненный прогресс-бар' do
        bar = described_class.new(25, 100)

        expect(bar.total_show).to eq("[#{"=" * 24}>#{"." * 75}] %25")
      end
    end

    context 'когда прогресс 75%' do
      it 'показывает три четверти заполненный прогресс-бар' do
        bar = described_class.new(75, 100)

        expect(bar.total_show).to eq("[#{"=" * 74}>#{"." * 25}] %75")
      end
    end

    context 'кастомная ширина бара' do
      it 'показывает прогресс-бар с шириной 50 символов' do
        bar = described_class.new(25, 50)

        expect(bar.total_show).to eq("[#{"=" * 24}>#{"." * 25}] %25")
      end

      it 'показывает прогресс-бар с шириной 20 символов' do
        bar = described_class.new(10, 20)

        expect(bar.total_show).to eq("[#{"=" * 9}>#{"." * 10}] %10")
      end
    end
  end

  describe '#update' do
    let(:bar) { described_class.new(0, 100) }

    it 'увеличивает прогресс на указанное значение' do
      bar.update(10)

      expect(bar.instance_variable_get(:@total)).to eq(10)
    end

    it 'может быть вызван несколько раз' do
      bar.update(10)
      bar.update(20)
      bar.update(30)

      expect(bar.instance_variable_get(:@total)).to eq(60)
    end

    it 'обновляет прогресс до 100%' do
      bar = described_class.new(50, 100)
      bar.update(50)

      expect(bar.total_show).to eq("[#{"=" * 99}>] %100")
    end

    it 'позволяет прогрессу превысить 100%' do
      bar = described_class.new(90, 100)
      bar.update(20)

      expect(bar.instance_variable_get(:@total)).to eq(110)
    end
  end

  describe '#update_line' do
    let(:bar) { described_class.new(0, 100) }
    let(:test_text) { '[==========>..........] %50' }

    it 'выводит текст в STDOUT с очисткой строки' do
      expect(STDOUT).to receive(:print).with("\r\e[2K#{test_text}")
      expect(STDOUT).to receive(:flush)

      bar.update_line(test_text)
    end

    it 'использует print для вывода текста' do
      expect(STDOUT).to receive(:print).with("\r\e[2K#{test_text}")
      expect(STDOUT).to receive(:flush)

      bar.update_line(test_text)
    end

    it 'вызывает flush после вывода' do
      expect(STDOUT).to receive(:print)
      expect(STDOUT).to receive(:flush).ordered

      bar.update_line(test_text)
    end

    it 'очищает строку перед выводом нового текста' do
      expect(STDOUT).to receive(:print).with("\r\e[2KПервая строка").ordered
      expect(STDOUT).to receive(:print).with("\r\e[2KВторая строка").ordered
      expect(STDOUT).to receive(:flush).twice

      bar.update_line('Первая строка')
      bar.update_line('Вторая строка')
    end
  end

  describe 'граничные случаи' do
    context 'отрицательный прогресс' do
      it 'позволяет установить отрицательный прогресс при инициализации' do
        bar = described_class.new(-10, 100)

        expect(bar.instance_variable_get(:@total)).to eq(-10)
      end

      it 'позволяет обновить до отрицательного значения' do
        bar = described_class.new(0, 100)
        bar.update(-5)

        expect(bar.instance_variable_get(:@total)).to eq(-5)
      end
    end

    context 'нулевая ширина бара' do
      it 'создаёт прогресс-бар с нулевой шириной' do
        bar = described_class.new(0, 0)

        expect(bar.total_show).to eq("[>] %0")
      end
    end

    context 'очень маленькая ширина бара' do
      it 'работает с шириной 1 символ' do
        bar = described_class.new(1, 1)

        expect(bar.total_show).to eq("[>] %1")
      end
    end
  end
end
