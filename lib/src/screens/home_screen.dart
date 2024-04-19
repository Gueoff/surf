import 'package:surf/src/components/header.dart';
import 'package:surf/src/screens/spot_details.dart';
import 'package:surf/src/services/api_service.dart';
import 'package:surf/src/components/text_input.dart';

import 'package:flutter/material.dart';
import 'package:surf/src/models/api_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  var suggests = <SuggestOption>[];
  final searchController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter += 1;
    });
  }

  void _onSearch(String value) async {
    final apiService = ApiService(endpoint: 'toto');
    try {
      var response = await apiService.searchSpot(value);
      print(response);
      setState(() {
        suggests = response;
      });
    } catch (error) {
      print(error);
    }
  }

  void _onNavigateToSpotDetailsSreen(SuggestOption suggestOption) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SpotDetailsScreen(spotId: suggestOption.id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Header(title: 'Welcome man'),
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
                        _onSearch(val);
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
                        _onNavigateToSpotDetailsSreen(suggestOption);
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
