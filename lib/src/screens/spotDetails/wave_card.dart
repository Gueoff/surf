import 'package:flutter/material.dart';
import 'package:surf/src/models/wave.dart';
import 'package:intl/intl.dart';

class WaveCard extends StatelessWidget {
  final Wave wave;
  final timeFormatter = DateFormat.Hm();
  late DateTime dateTime;

  WaveCard({Key? key, required this.wave});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      shadowColor: const Color.fromRGBO(97, 216, 240, 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16, right: 24, bottom: 16, left: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('tocard',
                      style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
