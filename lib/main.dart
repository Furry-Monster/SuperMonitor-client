import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/app_routes.dart';
import 'routes/route_manager.dart';
import 'theme/app_theme.dart';
import 'theme/theme_manager.dart';
import 'l10n/app_localizations.dart';
import 'l10n/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RouteManager()),
        ChangeNotifierProvider(create: (_) => ThemeManager(prefs)),
        ChangeNotifierProvider(create: (_) => LanguageManager(prefs)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeManager, LanguageManager>(
      builder: (context, themeManager, languageManager, child) {
        return MaterialApp(
          title: 'Super Monitor',
          theme: AppTheme.light(themeManager),
          darkTheme: AppTheme.dark(themeManager),
          themeMode: themeManager.themeMode,
          locale: languageManager.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: LanguageManager.supportedLocales,
          home: const MainScreen(),
        );
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteManager>(
      builder: (context, routeManager, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(AppRoutes.getCurrentTitle(routeManager.currentIndex)),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: AppRoutes.getDrawerItems(context, routeManager),
            ),
          ),
          body: IndexedStack(
            index: routeManager.currentIndex,
            children: AppRoutes.getScreens(),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: routeManager.currentIndex,
            onDestinationSelected: (index) {
              routeManager.navigateToIndex(index, context);
            },
            destinations: AppRoutes.getNavigationDestinations(),
          ),
        );
      },
    );
  }
}
