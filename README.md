# Общие настройки

Настройка `views_store_timeout` устанавливает таймаут после которого пользователь перестал смотреть видео. Настройка `views_store_cleanup` устанавливает частоту пересчета кол-ва зрителей для всех видео.

```ruby
config.views_store_timeout = 6.seconds
config.views_store_cleanup = 1.minute
```

# Варианты хранилищ

## Local store

Хранилище хранит данные в ruby hash. Подходит для веб-сервера thin и EventMachine в single thread варианте.

```ruby
config.views_store_type = :local_store
```

# Concurrent store

Хранит данные в Concurrent::Map, позволяет использовать приложение в multi thread режиме.
Подходит для веб-сервера puma в single process варианте.

```ruby
config.views_store_type = :concurrent_store
```

# Redis store

Хранит данные в redis в структурах Sorted sets. Данный вариант нужно использовать на продакшене,
так как поддеживает и multi thread и multi server режимы. Подходить для любого веб-сервера.


```ruby
config.views_store_url = "redis://localhost:6379/0"
config.views_store_timeout = 6.seconds
config.views_store_cleanup = 1.minute
```
