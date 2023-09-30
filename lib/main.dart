import 'package:crypto_currency_tracker_and_news/pages/HomePage.dart';
import 'package:crypto_currency_tracker_and_news/providers/market_provider.dart';
import 'package:crypto_currency_tracker_and_news/providers/theme_provider.dart';
import 'package:crypto_currency_tracker_and_news/services/LocalStorage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto_currency_tracker_and_news/providers/news_provider.dart';
import 'constants/Themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme = await LocalStorage.getTheme() ?? "light";

  runApp(MyApp(
    theme: currentTheme,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;

  MyApp({required this.theme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: (context) => MarketProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(theme),
        ),
        ChangeNotifierProvider<NewsProvider>(
          create: (context) => NewsProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
