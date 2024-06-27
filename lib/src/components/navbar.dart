import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:surf/src/screens/webview/webview_screen.dart';

class Navbar extends StatelessWidget {
  const Navbar({
    super.key,
  });

  void onNavigate(BuildContext context, String url, String title) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebviewScreen(url: url, title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/menu.jpg'),
                    fit: BoxFit.cover)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/icon.svg',
                  width: 36,
                  height: 36,
                  semanticsLabel: 'Logo',
                ),
                const SizedBox(width: 4),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            onTap: () => onNavigate(
                context,
                'https://surf.leaff.me/legal-notices.html',
                AppLocalizations.of(context)!.legalNotices),
            title: Text(
              AppLocalizations.of(context)!.legalNotices,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            onTap: () => onNavigate(
                context,
                'https://surf.leaff.me/terms-of-use.html',
                AppLocalizations.of(context)!.termsOfUse),
            title: Text(
              AppLocalizations.of(context)!.termsOfUse,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            onTap: () => onNavigate(
                context,
                'https://surf.leaff.me/privacy-policy.html',
                AppLocalizations.of(context)!.privacyPolicy),
            title: Text(
              AppLocalizations.of(context)!.privacyPolicy,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
        ],
      ),
    );
  }
}
