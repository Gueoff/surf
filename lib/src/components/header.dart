import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? icon;

  const Header({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 24, right: 24, top: MediaQuery.of(context).padding.top + 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/icon.svg',
                    width: 36,
                    height: 36,
                    semanticsLabel: 'Logo',
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.headlineSmall,
                )
            ],
          ),
          /*Icon(
            Icons.notifications,
            size: 24,
            color: Theme.of(context).colorScheme.tertiary,
          ),*/
        ],
      ),
    );
  }
}
