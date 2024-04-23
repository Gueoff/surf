import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf/src/theme/theme.dart';
import 'package:surf/src/screens/home/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Surf with me',
        theme: ThemeStyle.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}
