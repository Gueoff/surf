import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final String? subtitle;

  const Header({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 24, right: 24, top: MediaQuery.of(context).padding.top),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.titleMedium,
                )
            ],
          ),
          Icon(
            Icons.notifications,
            size: 24,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ],
      ),
    );
  }
}
