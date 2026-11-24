# PHP Docker

[![Stack](https://skillicons.dev/icons?i=php,postgresql,redis,bun)](https://skillicons.dev)

Образ PHP-окружения, собранный на основе кастомного `Dockerfile`.

В образе предустановлены адаптеры Redis и PostgreSQL. И инструменты для управления зависимостями Composer и Bun.

## Использование

### Отдельный Dockerfile

Скачать Dockerfile из нужного релиза
```
curl https://raw.githubusercontent.com/vesh95/php.dockerfile/refs/tags/v8.5/Dockerfile > Dockerfile
```

#### Собрать образ
`docker build .`

#### Использовать через docker-compose
```yaml
services:
  php:
    build:
      context: .
      dockerfile: Dockerfile
    volumes:
      - ./app:/var/www/html
    working_dir: /var/www/html
```

### В docker-compose
```yaml
services:
  php:
    image: ghcr.io/vesh95/php.dockerfile:latest
    volumes:
      - ./app:/var/www/html
    working_dir: /var/www/html
```

### Прямой запуск

`docker run -it --rm ghcr.io/vesh95/php.dockerfile:latest php -v`

## Загрузка образа

Образ публичный, авторизация не требуется.

### Загрузить последнюю версию

`docker pull ghcr.io/vesh95/php.dockerfile:latest`

### Загрузить конкретную версию (тег релиза)
`docker pull ghcr.io/vesh95/php.dockerfile:v8.5`

Тег версии в точности совпадает с тегом, который вы указали при создании GitHub Release. Например, если релиз создан с тегом v8.5, то и Docker-образ будет доступен как v8.5. Теги версии php совпадают с тегами релизов.

### Как базовый образ
```dockerfile
FROM ghcr.io/vesh95/php.dockerfile:latest
COPY . /var/www/html
```
## Теги образа
При создании GitHub Release workflow публикует два тега:

|Тег	|Пример	|Описание|
|---|---|---|
|latest	|latest	|Всегда указывает на последний собранный образ. Перезаписывается при каждом релизе.|
|Тег релиза	|v1.0.0|	В точности повторяет тег, указанный при создании GitHub Release.|

Оба тега указывают на один и тот же образ, собранный из текущего состояния репозитория на момент релиза. latest удобно использовать для разработки и тестирования, а версионный тег — для продакшена и фиксации зависимостей.

## Метаданные образа
В образ внедрены стандартные OCI-метки. Посмотреть их можно через docker inspect:

```bash
docker inspect ghcr.io/vesh95/php.dockerfile:latest --format '{{json .Config.Labels}}'
```
Доступны следующие метки:

org.opencontainers.image.source — адрес репозитория с исходным кодом

org.opencontainers.image.revision — SHA коммита на момент сборки

org.opencontainers.image.version — версия образа (latest или тег релиза)

## Процесс автоматической сборки
Публикация образа управляется GitHub Actions. При создании нового Release в GitHub workflow автоматически выполняет:

## Лицензия
См. файл [MIT](LICENSE) в репозитории.

