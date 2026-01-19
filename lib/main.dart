import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      home: Scaffold(),
      debugShowCheckedModeBanner: false,
    );
  }
}
