import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneday_oneline/screens/history_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:oneday_oneline/screens/splash_screen.dart';
import 'package:oneday_oneline/screens/home_screen.dart';
import 'services/isar_service.dart';
import 'utils/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('tr_TR', null);
  // Isar'ı başlat
  await IsarService.initialize();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "1 Day 1 Line",
      theme: AppTheme.darkTheme,
      home: FutureBuilder<bool>(
        future: _shouldShowSplash(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.data == true) {
            return SplashScreen();
          } else {
            return HomeScreen();
          }
        },
      ),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/history': (context) => const HistoryScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }

  Future<bool> _shouldShowSplash() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool('splash_shown') ?? false);
  }
}
