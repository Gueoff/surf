import 'package:flutter/material.dart';
import 'package:surf/src/screens/home/home_screen.dart';
import 'package:surf/src/screens/spotDetails/spot_details_screen.dart';
import 'package:surf/src/models/spot.dart';

class RouterService {
  static const homeScreen = '/';
  static const spotDetailsScreen = '/spot/details';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case spotDetailsScreen:
        if (settings.arguments is Spot) {
          final spot = settings.arguments as Spot;
          return MaterialPageRoute(
              builder: (_) => SpotDetailsScreen(spot: spot));
        }

        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic>? _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    });
  }
}
