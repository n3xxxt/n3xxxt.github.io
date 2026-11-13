# Андрей Никитцев — визитка

Визитка-приложение на Flutter Web: Flutter-разработчик и основатель NotDoneByOne.
Сайт: https://n3xxxt.github.io

На десктопе приложение показывается в рамке телефона рядом с коротким описанием, на мобильных — на весь экран.

## Запуск

```
flutter pub get
flutter run -d chrome
```

## Сборка

```
flutter build web --release
```

Результат — `build/web`.

## Фото

Положите фото в `web/photo.jpg` (соотношение 3:4, примерно 600×800). Приложение берёт его по относительному пути `photo.jpg`; без файла показывается заглушка.

## Публикация

1. Создайте репозиторий `n3xxxt.github.io` на GitHub.
2. В Settings → Pages выберите Source: GitHub Actions.
3. Запушьте код в `main` — workflow `.github/workflows/pages.yml` соберёт и опубликует сайт.
