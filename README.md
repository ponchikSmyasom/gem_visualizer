# GemVisualizer

Визуализация прогресс-баров для консольных приложений Ruby.

## Установка

Добавьте в Gemfile:

```ruby
gem 'gem_visualizer'
```

Или установите через gem:

```bash
gem install gem_visualizer
```

## Использование

```ruby
require 'gem_visualizer'

# Создание прогресс-бара
bar = GemVisualizer::ProgressBar.new(0, 50)

# Обновление прогресса
bar.update(10)
puts bar.total_show  # [=========>........................................] %20

# Вывод в одной строке
bar.update_line(bar.total_show)
```

## API

### `ProgressBar.new(total, bar_width)`

- `total` — начальное значение прогресса
- `bar_width` — ширина бара в символах (100%)

### `#update(progress)`

Увеличивает прогресс на указанное значение. Не позволяет превысить `bar_width` или уйти в отрицательные значения.

### `#total_show`

Возвращает строковое представление прогресс-бара.

### `#update_line(text)`

Выводит текст в STDOUT с очисткой текущей строки.

## Разработка

```bash
# Установка зависимостей
bin/setup

# Запуск тестов
rake test

# Интерактивная консоль
bin/console
```

## Лицензия

MIT
