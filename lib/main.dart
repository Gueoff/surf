import 'package:surf/src/services/api_service.dart';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf/src/theme/theme.dart';
import 'package:surf/src/models/api_response.dart';
import 'package:surf/src/screens/home_screen.dart';

void main() {
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
        home: HomeScreen(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[];
  var suggests = <SuggestOption>[];

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void onPressFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }

    notifyListeners();
  }

  void onSearch(String value) async {
    final apiService = ApiService(endpoint: 'toto');
    try {
      suggests = await apiService.searchSpot(value);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
