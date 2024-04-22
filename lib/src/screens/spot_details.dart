import 'package:flutter/material.dart';
import 'package:surf/src/components/header.dart';

class SpotDetailsScreen extends StatelessWidget {
  final String spotId;

  const SpotDetailsScreen({super.key, required this.spotId});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            BackButton(),
            Header(title: 'Welcome man'),
          ],
        ),
      ),
    );
  }
}
