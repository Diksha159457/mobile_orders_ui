// Imports core Flutter rendering tools and UI widget paradigms.
import 'package:flutter/material.dart';
// Imports our centralized configuration for styling and themes.
import 'app_theme.dart';
// Imports the primary entry screen of our open orders view.
import 'screens/orders_screen.dart';

// The true starting point/entrypoint of the Flutter application when launched.
void main() {
  // Boots up the framework with our root widget, TradingApp.
  runApp(const TradingApp());
}

// Our root application widget, responsible for declaring top-level configurations.
class TradingApp extends StatelessWidget {
  // A const constructor is used to improve render performance since it doesn't change state.
  const TradingApp({super.key});

  // The build method constructs the widget tree for the application routing.
  @override
  Widget build(BuildContext context) {
    // MaterialApp is the base widget providing a wrapper for material UI features.
    return MaterialApp(
      // The name of the application, used occasionally by the OS task switcher.
      title: 'Open Orders UI',
      // Removes the "DEBUG" sash commonly overlaid in development builds.
      debugShowCheckedModeBanner: false,
      // Sets the default theme mappings configured in our AppTheme object for pure light mode.
      theme: AppTheme.lightTheme,
      // Sets the alternate dark theme mappings which execute if the user prefers dark mode.
      darkTheme: AppTheme.darkTheme,
      // Instructs the application to listen to the device's system-level dark mode toggle.
      themeMode: ThemeMode.system, 
      // Declares the initial screen the user will see once the app boots.
      home: const OrdersScreen(),
    );
  }
}
