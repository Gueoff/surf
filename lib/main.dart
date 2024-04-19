import 'package:surf/src/components/header.dart';
import 'package:surf/src/services/api_service.dart';
import 'package:surf/src/components/text_input.dart';

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
/*
class MyHomePage extends StatelessWidget {
  int _counter = 0;
  final searchController = TextEditingController();

  void _incrementCounter() {}

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var suggests = appState.suggests;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Header(title: 'Welcome'),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Textinput(
                    controller: searchController,
                    hintText: 'Location',
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).colorScheme.tertiary),
                    obscureText: false,
                    onChanged: (val) {
                      if (val != null) {
                        appState.onSearch(val);
                      }

                      return null;
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      }
                      return null;
                    }),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: suggests.length,
                  itemBuilder: (BuildContext context, int index) {
                    final suggestOption = suggests[index];
                    return ListTile(
                      title: Text(suggestOption.text),
                      subtitle: Text(suggestOption.type),
                      onTap: () {
                        print('Option sélectionnée: $suggestOption');
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
*/