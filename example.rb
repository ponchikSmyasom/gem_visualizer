# frozen_string_literal: true

require_relative 'lib/gem_visualizer'

# Пример 1: Простой прогресс-бар
puts "=== Пример 1: Прогресс от 0 до 100% ==="
bar = GemVisualizer::ProgressBar.new(0, 50)

5.times do |i|
  bar.update(10)
  bar.update_line(bar.total_show)
  sleep(0.5)
end

puts "\n=== Пример 2: Анимация в одной строке ==="
bar2 = GemVisualizer::ProgressBar.new(0, 10)

10.times do |i|
  bar2.update(1)
  bar2.update_line(bar2.total_show)
  sleep 0.3
end

puts "\n\n=== Пример 3: Разные размеры (50% заполнено) ==="
[10, 20, 30].each do |width|
  bar3 = GemVisualizer::ProgressBar.new(width / 2, width)
  puts "Ширина #{width}: #{bar3.total_show}"
end

puts "\n=== Пример 4: Граничные случаи ==="
bar4 = GemVisualizer::ProgressBar.new(0, 10)
puts "Начало: #{bar4.total_show}"

bar4.update(-5)
puts "После update(-5): #{bar4.total_show}"

bar4.update(15)
puts "После update(15) (превышение): #{bar4.total_show}"
