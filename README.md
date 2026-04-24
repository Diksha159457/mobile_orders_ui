# Mobile Orders UI

A Flutter interface for viewing and managing open trading orders in a mobile-friendly layout. The app focuses on polished card-based presentation, filter chips, search, pagination, and quick order cancellation interactions.

## Highlights

- Card-based open orders layout optimized for mobile screens
- Buy, sell, CNC, and NRML filters
- Search bar and paginated order list
- Swipe or tap-based order cancellation flows
- Light and dark theme support

## Tech Stack

- Flutter
- Dart
- `flutter_slidable`
- `google_fonts`
- `intl`

## Project Structure

```text
mobile_orders_ui/
├── lib/
│   ├── main.dart
│   ├── app_theme.dart
│   ├── models/order.dart
│   ├── screens/orders_screen.dart
│   └── widgets/
│       ├── filter_chips.dart
│       ├── order_card.dart
│       └── search_input.dart
├── test/
│   └── widget_test.dart
└── pubspec.yaml
```

## Run Locally

```bash
git clone https://github.com/Diksha159457/mobile_orders_ui.git
cd mobile_orders_ui
flutter pub get
flutter run
```

## Deployment

This repository includes a GitHub Pages workflow for the Flutter web build.

- On every push to `main`, GitHub Actions builds the app for web and publishes it to GitHub Pages.
- After Pages is enabled for the repository, the public URL should be:
  `https://diksha159457.github.io/mobile_orders_ui/`

## Resume Value

This project demonstrates Flutter component design, stateful filtering and pagination, custom theming, and mobile-focused UI composition for a trading workflow.

## Future Improvements

- Connect the UI to a live orders API
- Add sorting and richer search behavior
- Add portfolio summary and analytics panels
- Add widget and golden tests for core views

## License

MIT. See [LICENSE](LICENSE).
